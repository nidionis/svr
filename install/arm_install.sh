#!/usr/bin/bash

set -euo pipefail

cleanup() {
    set +e
    umount -l "$MOUNT_DIR/dev" "$MOUNT_DIR/sys" "$MOUNT_DIR/proc" 2>/dev/null
    umount -l "$MOUNT_DIR/boot" "$MOUNT_DIR" 2>/dev/null
    [ -n "${LOOPDEV:-}" ] && losetup -d "$LOOPDEV" 2>/dev/null
}
trap cleanup EXIT


IMG_URL="https://downloads.raspberrypi.org/raspios_lite_armhf_latest"
IMG_FILE="raspios_lite.img"
COMPR_IMG="raspios_lite.img.xz"
MOUNT_DIR="/mnt/rpi"
SSH_PORT=888
WIFI_SSID="$1"
WIFI_PASS="$2"
ROOT_PASS="$3"

if [ ! -e $IMG_FILE ] ; then
	if [ ! -e $COMPR_IMG ] ; then
		wget -O ${COMPR_IMG} "$IMG_URL"
		wget -O "${IMG_FILE}.sha256" "${IMG_URL}.sha256"
		cd $(dirname "$IMG_FILE")
		sha256sum -c "${COMPR_IMG}.sha256" --status
		if [ $? -ne 0 ]; then
			echo "SHA256 mismatch ! Aborting."
			exit 1
		else
			echo "shasum ok"
		fi
		cd -
	fi
	unxz -f "$COMPR_IMG"
fi

apt-get install qemu-user-static binfmt-support
cp /usr/bin/qemu-arm-static $MOUNT_DIR/usr/bin/

# 2. Associer l’image à un loop device
LOOPDEV=$(losetup --find --partscan --show "$IMG_FILE")
BOOTPART="${LOOPDEV}p1"
ROOTPART="${LOOPDEV}p2"

parted --script "$LOOPDEV" resizepart 2 100%
e2fsck -f -y "$ROOTPART"
resize2fs "$ROOTPART"

mkdir -p "$MOUNT_DIR"
mount "$ROOTPART" "$MOUNT_DIR"
mount "$BOOTPART" "$MOUNT_DIR/boot"

mount --bind /dev "$MOUNT_DIR/dev"
mount --bind /sys "$MOUNT_DIR/sys"
mount --bind /proc "$MOUNT_DIR/proc"
cp /etc/resolv.conf "$MOUNT_DIR/etc/"

chroot "$MOUNT_DIR" /bin/bash <<EOF
set -e

# Paquets nécessaires
apt-get update
apt-get install -y docker.io docker-compose ufw

# Dossier deb_dock
mkdir -p /root/machine
# (copie depuis l’extérieur faite plus tard)

# SSH
echo "root:${ROOT_PASS}" | chpasswd
sed -i "s/^#Port.*/Port ${SSH_PORT}/" /etc/ssh/sshd_config
sed -i "s/^#PermitRootLogin.*/PermitRootLogin yes/" /etc/ssh/sshd_config
sed -i "s/^#PasswordAuthentication.*/PasswordAuthentication yes/" /etc/ssh/sshd_config

# UFW
ufw --force reset
ufw default deny incoming
ufw allow ${SSH_PORT}/tcp
ufw --force enable

# Wi-Fi
cat > /etc/wpa_supplicant/wpa_supplicant.conf <<WIFI
country=FR
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="${WIFI_SSID}"
    psk="${WIFI_PASS}"
}
WIFI

# Service run_ssh
cat > /etc/systemd/system/run_ssh.service <<SERV
[Unit]
Description=Run SSH init docker
After=network.target

[Service]
ExecStart=/root/machine/deb_dock/run_ssh.sh
Restart=always

[Install]
WantedBy=multi-user.target
SERV

systemctl enable run_ssh.service
EOF

# 6. Copier deb_dock
rsync -a machine/deb_dock/ "$MOUNT_DIR/root/machine/deb_dock/"

# 7. Nettoyage
umount -l "$MOUNT_DIR/dev" "$MOUNT_DIR/sys" "$MOUNT_DIR/proc"
umount -l "$MOUNT_DIR/boot" "$MOUNT_DIR"
losetup -d "$LOOPDEV"

echo "Image prête. Écrivez-la sur SSD avec: sudo dd if=${IMG_FILE%.xz} of=/dev/sdX bs=4M status=progress"

