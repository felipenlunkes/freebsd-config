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

pkg install xorg 
pkg install nano bash networkmgr wifimgr security/sudo
pkg install sddm
pkg install kde5
pkg intall drm-kmod

# Settings in /etc/rc.conf

echo "Now, let's create and edit some configuration files..."

echo 'dbus_enable="YES"' >> /etc/rc.conf
echo 'hald_enable="YES"' >> /etc/rc.conf
echo 'sddm_enable="YES"' >> /etc/rc.conf
echo 'sddm_lang="pt_BR.UTF-8"' >> /etc/rc.conf # Language: Portuguese (Brazil)
echo 'kld_list="kld_list="/boot/modules/$CARD0.ko acpi_video"' >> /etc/rc.conf
echo 'wlans_ath0="wlan1"' >> /etc/rc.conf
echo 'ifconfig_wlan1="WPA SYNCDHCP"' >> /etc/rc.conf
echo 'ifconfig_re0="DHCP"' >> /etc/rc.conf
echo 'ifconfig_re0_ipv6="inet6 accept_rtadv"' >> /etc/rc.conf
echo 'create_args_wlan0="country BR regdomain XC900M"' >> /etc/rc.conf

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
