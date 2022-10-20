#!/bin/sh
#
# Script que instala e configura automaticamente pacotes necessários
# para o uso do FreeBSD com interface gráfica (KDE Plasma) e Wi-Fi
#
# Copyright (C) 2022 Felipe Miguel Nery Lunkes
#

# Primeiro devemos atualizar o catálogo do pkg

pkg update

# Agora devemos instalar os pacotes necessários

pkg install xorg 
pkg install nano bash networkmgr
pkg install sddm
pkg install kde5
pkg intall drm-kmod

echo 'dbus_enable="YES"' >> /etc/rc.conf
echo 'hald_enable="YES"' >> /etc/rc.conf
echo 'sddm_enable="YES"' >> /etc/rc.conf
echo 'sddm_lang="pt_BR.UTF-8"' >> /etc/rc.conf # Idiomta Português (Brasil)

# Agora, montar /proc a cada inicialização, necessário para o KDE e outros serviços

echo "proc     /proc     procfs     rw     0     0" >> /etc/fstab

# Adiciona o usuário apra utilizar os serviços de vídeo

pw groupmod wheel -m $USER

reboot
