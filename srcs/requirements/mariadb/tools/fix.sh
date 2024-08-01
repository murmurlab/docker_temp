sed -i "s|.*bind-address\s*=.*|bind-address=$(getent hosts db | awk '{ print $1 }')|g" /etc/my.cnf.d/mariadb-server.cnf

sh /root/setup.sh > /setup.sql
# chown mysql /setup.sql
chmod 777 /setup.sql

mariadbd-safe --init-file=/setup.sql
