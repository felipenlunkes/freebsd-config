#!/bin/sh
#
# Script que instala e configura automaticamente pacotes necessários
# para o uso do FreeBSD com interface gráfica (KDE Plasma) e Wi-Fi
#
# Copyright (C) 2022 Felipe Miguel Nery Lunkes
#
# Licenciado sob BSD-3-clause

# Primeiro devemos atualizar o catálogo do pkg

# Primeiro, escolha qual o driver correto para a sua placa de vídeo. Você precisa
# conhecer apenas o fornecedor da placa. 
#
# Se você utiliza apenas a placa de vídeo integrada da Intel, escolha abaixo i915
# Se você utiliza uma placa integrada ou dedicada Radeon, escolha radeonkms
# Se você utiliza placas antigas da AMD, escolha amdgpu
#
# Agora altere o valor entre parênteses na variável abaixo (CARD0) com a sua escolha:

CARD0="radeonkms"

pkg update

# Agora devemos instalar os pacotes necessários

pkg install xorg 
pkg install nano bash networkmgr wifimgr security/sudo
pkg install sddm
pkg install kde5
pkg intall drm-kmod

# Configurações contidas em /etc/rc.conf

echo 'dbus_enable="YES"' >> /etc/rc.conf
echo 'hald_enable="YES"' >> /etc/rc.conf
echo 'sddm_enable="YES"' >> /etc/rc.conf
echo 'sddm_lang="pt_BR.UTF-8"' >> /etc/rc.conf # Idioma Português (Brasil)
echo 'kld_list="kld_list="/boot/modules/$CARD0.ko acpi_video"' >> /etc/rc.conf
echo 'wlans_ath0="wlan1"' >> /etc/rc.conf
echo 'ifconfig_wlan1="WPA SYNCDHCP"' >> /etc/rc.conf
echo 'ifconfig_re0="DHCP"' >> /etc/rc.conf
echo 'ifconfig_re0_ipv6="inet6 accept_rtadv"' >> /etc/rc.conf
echo 'create_args_wlan0="country BR regdomain XC900M"' >> /etc/rc.conf

# Criar arquivo vazio wpa_supplicant.conf (populado por wifimgr)

touch /etc/wpa_supplicant.conf

# Configurações em /boot/loader.conf

echo 'kern.vty=vt' >> /boot/loader.conf # Necessário para Xorg
echo 'if_ath_load="YES"' >> /boot/loader.conf # Carregar driver para placa de rede sem fio Atheros

# Agora, montar /proc a cada inicialização, necessário para o KDE e outros serviços

echo "proc     /proc     procfs     rw     0     0" >> /etc/fstab

# Adiciona o usuário apra utilizar os serviços de vídeo

pw groupmod wheel -m $USER
pw groupmod video -m $USER 

# Agora vamos inserir o usuário atual em sudoers, para usar o sudo

echo "$USER ALL=(ALL:ALL) ALL" >> /usr/local/etc/sudoers

freebsd-update fetch

freebsd-update install
freebsd-update install 

reboot
