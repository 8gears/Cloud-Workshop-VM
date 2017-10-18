#!/usr/bin/env bash
echo -e "\e[1;32m   Initial Update & Upgrade    \e[0m"
echo -e "\e[1;32m-------------------------------\e[0m"

export DEBIAN_FRONTEND="noninteractive"

#"sudo add-apt-repository ppa:hermlnx/xrdp",
apt-get -qq update

echo -e "\e[1;32m     Upgrading System          \e[0m"
echo -e "\e[1;32m-------------------------------\e[0m"
grub-install /dev/sda
apt-get upgrade -y -qq -o Dpkg::Options::='--force-confold' --auto-remove


echo -e "\e[1;32m     Installing Desktop        \e[0m"
echo -e "\e[1;32m-------------------------------\e[0m"
apt-get install -y -qq -o Dpkg::Options::='--force-confold' ubuntu-desktop
