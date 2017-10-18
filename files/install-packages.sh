#!/usr/bin/env bash
export DEBIAN_FRONTEND="noninteractive"

echo "Installing some packages using apt-get..."
echo "Install as:: $(whoami)"

# add repository for microsoft visualstudio code packages
curl -sS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

echo apt-get update 
apt-get update || while pgrep aptd; do pkill -e aptd; sleep 5; done && apt-get update

# remove some discouraged packages
apt-get purge -y -qq --auto-remove libreoffice libreoffice-common unity-webapps-common thunderbird transmission-gtk transmission-common simple-scan deja-dup shotwell cheese

# remove games
apt-get purge -y -qq --auto-remove aisleriot gnome-sudoku mahjongg ace-of-penguins gnomine gbrainy gnome-mines

# install some packages
echo apt-get install/update some packages
apt-get install -y -qq dos2unix vim code

# install openbox, a spartanic and resource-saving window manager (to start it, logout and choose window manager)
#apt-get install -y openbox pcmanfm

# clean
echo "apt-get autoremove -y"
apt-get autoremove -y
echo "apt-get autoclean -y"
apt-get autoclean -y 

echo "...apt-get done."

# do upgrade
#export DEBIAN_FRONTEND=noninteractive
#sudo grub-install /dev/sda
#apt-get upgrade -y -qq --auto-remove
