FROM alpine:latest

# Install base packages
RUN apk add \
    librewolf
#    xorg-xhost \
#    dbus \
#    sudo \
#    mesa \
#    alsa-utils \
#    xorg-xprop \
#    pulseaudio

RUN useradd -m -G wheel painain \
    && echo "%wheel ALL=(ALL) ALL, !/usr/bin/passwd root" >> /etc/sudoers

USER painpain
WORKDIR /home/painpain

#ENTRYPOINT [""]
