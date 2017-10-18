#!/usr/bin/env bash


if [ "$LANG" != "en_US.UTF-8" ]; then
    echo "setting locale en_US.UTF-8"
    locale-gen
    localectl set-locale LANG="en_US.UTF-8"
    systemctl restart lightdm
fi

echo "Ensuring UI is started.."
systemctl start lightdm
