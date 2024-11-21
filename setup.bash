#!/bin/bash

echo "127.0.0.1       $2.42.fr" >> /etc/hosts
zypper install -y make docker-compose docker git

firewall-cmd --permanent --zone=public --add-port=22/tcp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --reload

systemctl start docker
systemctl enable docker
systemctl start sshd
systemctl enable sshd

# RUN --mount=type=secret,id=WP_ADMIN_LOGIN \
# 	WP_ADMIN_LOGIN="$(cat /run/secrets/WP_ADMIN_LOGIN)" && \
# 	echo aaa"$WP_ADMIN_LOGIN"

# docker swarm init

# echo murmur42 | docker secret create WP_ADMIN_LOGIN -
# echo ultraSecret4.2 | docker secret create WP_ADMIN_PASSW -
# echo wp | docker secret create WP_DB_NAME -
# echo guest42 | docker secret create WP_GUEST_LOGIN -
# echo guest123 | docker secret create WP_GUEST_PASSW -
# echo $USER | docker secret create LOGIN_42 -

mkdir -p "$1/data/wp"
mkdir -p "$1/data/db"
mkdir -p "$1/sources/repos"

git clone https://github.com/murmurlab/docker_temp.git "$1/sources/repos/docker_temp"
chown -R $2 "$1/sources/"
chown -R $2 "$1/data/"

sed -i "s/LOGIN_42=ahbasara/LOGIN_42=$2/" "$1/sources/repos/docker_temp/srcs/.env"
