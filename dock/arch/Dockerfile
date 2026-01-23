FROM archlinux:latest

# Install base packages
RUN pacman -Syu --noconfirm \
    firefox
#    xorg-xhost \
#    dbus \
#    sudo \
#    mesa \
#    alsa-utils \
#    xorg-xprop \
#    pulseaudio

# Optional: create a user to avoid running as root
RUN useradd -m -G wheel painoain \
    && echo "archuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER archuser
WORKDIR /home/archuser

# Set Firefox as entrypoint
ENTRYPOINT ["firefox"]
