#!/bin/bash
zypper install -y make docker-compose docker git

firewall-cmd --permanent --zone=public --add-port=22/tcp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --reload

systemctl start docker
systemctl enable docker
systemctl start sshd
systemctl enable sshd

mkdir -p /home/ahbasara/data/wp
mkdir -p /home/ahbasara/data/db
mkdir -p "$1/sources/repos"

git clone https://github.com/murmurlab/docker_temp.git "$1/sources/repos/docker_temp"
