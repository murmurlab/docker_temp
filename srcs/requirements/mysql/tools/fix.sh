sed -i "s/bind-address=1.1.1.1/bind-address=$(getent hosts db | awk '{ print $1 }')/" /etc/my.cnf.d/mariadb-server.cnf
sh /root/setup.sh > /root/setup.sql
mysql </root/setup.sql
cp /var/wp/wordpress/wp-config-sample.php 
mariadbd-safe