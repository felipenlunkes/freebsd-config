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
# If you only use Intel integrated graphics, choose below i915
# If you use an integrated or dedicated Radeon card, choose radeonkms
# If you use old AMD cards, choose amdgpu
#
# Now change the value in the variable below (CARD0) with your choice:

CARD0="radeonkms"

echo "You selected the video card $CARD0. Is this correct?"
echo "Press <ENTER> to continue or CTRL-C to change."

read videocard 

echo "Ok!"

echo "Now let's check for updates in the pkg catalog..."

# First we must update the pkg catalog

pkg update

# Now we must install the necessary packages

echo "Now, let's install the necessary dependencies to run the graphical environment..."

pkg install -quiet --yes xorg 
pkg install -quiet --yes nano bash networkmgr wifimgr security/sudo
pkg install -quiet --yes sddm plasma5-sddm-kcm
pkg install -quiet --yes kde5
pkg install -quiet --yes drm-kmod

# Settings in /etc/rc.conf

echo "Now, let's create and edit some configuration files..."

sysrc dbus_enable="YES"
sysrc hald_enable="YES"
sysrc sddm_enable="YES"
sysrc ddm_lang="pt_BR.UTF-8"
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

# Add user to use video services

pw groupmod wheel -m $USER
pw groupmod video -m $USER 

# Now let's enter the current user in sudoers, to use sudo.

echo "$USER ALL=(ALL:ALL) ALL" >> /usr/local/etc/sudoers

# Now let's check for kernel and userland updates

echo "Time to check for important FreeBSD updates and install them if any..."

freebsd-update fetch

# Run freebsd-update install once for update the kernel

freebsd-update install

# And again for the userland

freebsd-update install 

echo "It's time to reboot! Press <ENTER> to reboot..."

read selection

reboot
