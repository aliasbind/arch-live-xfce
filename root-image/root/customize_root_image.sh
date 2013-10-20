#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/

useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /usr/bin/zsh arch

chmod 750 /etc/sudoers.d
chmod 440 /etc/sudoers.d/g_wheel

sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf
sed -i 's/#\(PermitEmptyPasswords\ \)no/\1yes/' /etc/ssh/sshd_config
sed -i 's/\(hosts:\ files\ dns\ myhostname\ \)/\1mdns/' /etc/nsswitch.conf

systemctl enable sshd.service avahi-daemon.service
systemctl enable graphical.target pacman-init.service choose-mirror.service
systemctl enable slim.service
