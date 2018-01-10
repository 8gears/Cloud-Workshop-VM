#!/usr/bin/env bash
export DEBIAN_FRONTEND="noninteractive"

echo stopping UI..
systemctl stop lightdm
while pgrep aptd; do pkill -e aptd; sleep 5; done

echo -e "\e[1;32m   Installing Docker...    \e[0m"
echo -e "\e[1;32m-------------------------------\e[0m"

wget -qO- https://get.docker.com/ | sh
systemctl enable docker
systemctl start docker

echo ...installing docker done.

echo -e "\e[1;32m   installing docker-compose...    \e[0m"
echo -e "\e[1;32m-------------------------------\e[0m"


curl -sS -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.15.0/docker-compose-$(uname -s)-$(uname -m)"
chmod +x /usr/local/bin/docker-compose

echo "...installing docker-compose done. Installed Version is $(docker-compose -v)"


[ -f /usr/local/bin/scw-metadata ] || echo "Granting user ubuntu Docker daemon access" && adduser ubuntu docker
