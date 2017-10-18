#!/bin/bash

# apply various user settings on every startup

# configuring 'us' and 'ch' keyboard layout
ui_langs=$(gsettings get org.gnome.desktop.input-sources sources)
if [[ $ui_langs == "@a(ss) []" ]]; then
  echo "Setting Languages CH and US"
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ch')]"  2>/dev/null
fi

# disable lock-screen
gsettings set org.gnome.desktop.screensaver lock-enabled false  2>/dev/null
gsettings set org.gnome.desktop.screensaver lock-delay 0  2>/dev/null
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false  2>/dev/null
gsettings set org.gnome.desktop.screensaver user-switch-enabled false  2>/dev/null
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false  2>/dev/null


# Set password of user ubuntu
if [ -z ${1+x} ]; then 
  echo "Password for user Ubuntu is not provided:"
  export UBUNTU_PASS=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)
  #echo "Generated Password for user ubuntu: ${UBUNTU_PASS}"
else 

  export UBUNTU_PASS=$1
fi
echo "ubuntu:${UBUNTU_PASS}" | chpasswd
echo "Password of User ubuntu was set to ${UBUNTU_PASS}"
