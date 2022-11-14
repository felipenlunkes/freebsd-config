#!/bin/sh
#
# Script that automatically installs and configures required packages
# for using FreeBSD with GUI (KDE Plasma) and Wi-Fi
#
# Copyright (C) 2022 Felipe Miguel Nery Lunkes
#
# Licensed under BSD-3-clause
#
# First, choose the correct driver for your video card. You need
# know only the card vendor.
#
# If you only use Intel integrated graphics, choose below i915kms
# If you use an integrated or dedicated Radeon card, choose radeonkms
# If you use old AMD cards, choose amdgpu
#
# Now change the value in the variable below (CARD0) with your choice:

CARD0="radeonkms"

clear

echo "Welcome to freebsd-config!"
echo
echo "freebsd-config will automatically configure your FreeBSD installation, installing"
echo "packages needed to use the graphical environment and useful tools, quickly and easily."
echo
echo "First, we must define the vendor of your video card. The options are:"
echo
echo "- i915 (cards provided by Intel, including HD Graphics;"
echo "- radeon (cards provided by AMD);"
echo "- amdgpu (old models of AMD graphics processors)."
echo
echo "You selected the video card $CARD0. Is this correct?"
echo "Press <ENTER> to continue or CTRL-C to change (edit config.sh)."

read VIDEOCARD 

echo "Ok!"
echo
echo "Now enter your (non-root) username to add it to the sudoers file (allows you to run commands"
echo -n "with root privileges): "

read USERSUDOERS

echo
echo "Ok! Let's continue!"
echo
echo "Now let's check for updates in the pkg catalog..."
echo

# First we must update the pkg catalog

pkg update

# Now we must install the necessary packages

echo "Now, let's install the necessary dependencies to run the graphical environment..."
echo "We will also install useful utilities such as a browser and text editor!"
echo

pkg install -q -y xorg nano bash networkmgr wifimgr security/sudo sddm plasma5-sddm-kcm kde5 drm-kmod
pkg install -q -y chromium firefox vscode gh

# Settings in /etc/rc.conf

echo "Now, let's create and edit some configuration files..."
echo

# The default language is Portuguese, but you can change it to use the language of your choice.

sysrc dbus_enable="YES"
sysrc hald_enable="YES"
sysrc sddm_enable="YES"
sysrc sddm_lang="pt_BR.UTF-8"
sysrc LANG="pt_BR.UTF-8"
sysrc LC_ALL="pt_BR.UTF-8"
sysrc kld_list="/boot/modules/$CARD0.ko acpi_video"
sysrc wlans_ath0="wlan1"
sysrc ifconfig_wlan1="WPA SYNCDHCP"
sysrc ifconfig_re0="DHCP"
sysrc ifconfig_re0_ipv6="inet6 accept_rtadv"
sysrc create_args_wlan0="country BR regdomain XC900M"

service dbus start

# Create empty wpa_supplicant.conf file (populated by wifimgr)

touch /etc/wpa_supplicant.conf

# Settings in /boot/loader.conf

echo 'kern.vty=vt' >> /boot/loader.conf # Required for Xorg
echo 'if_ath_load="YES"' >> /boot/loader.conf # Load driver for Atheros wireless network card

# Now mount /proc on every boot, needed for KDE and other services

echo "proc     /proc     procfs     rw     0     0" >> /etc/fstab

# Add user to wheel group

pw usermod $USERSUDOERS -G wheel

# Add user to use video services

pw groupmod wheel -m $USER
pw groupmod wheel -m $USERSUDOERS
pw groupmod video -m $USER
pw groupmod video -m $USERSUDOERS

# Now let's enter the current user in sudoers, to use sudo.

echo "$USER ALL=(ALL:ALL) ALL" >> /usr/local/etc/sudoers
echo "$USERSUDOERS ALL=(ALL:ALL) ALL" >> /usr/local/etc/sudoers

# Now let's check for kernel and userland updates

echo
echo "Time to check for important FreeBSD updates and install them if any..."
echo

# Run freebsd-update install once for update the kernel

freebsd-update fetch install

# And again for the userland

freebsd-update fetch install

echo
echo "All ready! Enjoy your new installation of FreeBSD with GUI and Wi-Fi!"
echo
echo "It's time to reboot! Press <ENTER> to reboot..."

read selection

reboot
