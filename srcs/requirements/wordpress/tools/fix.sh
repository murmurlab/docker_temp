#!/bin/sh
sed -i "s/^listen = 127.0.0.1/listen = $(getent hosts wp | awk '{ print $1 }')/" /etc/php83/php-fpm.d/www.conf

# php /usr/local/bin/wp config create --path=/var/wp --dbname="$WP_DB_NAME" --dbuser="$WP_ADMIN_LOGIN" --dbpass="$WP_ADMIN_PASSW" --dbhost="db" --dbprefix="wp_"
# getent hosts db | awk '{print $1}'

WP_DB_NAME=`cat /run/secrets/WP_DB_NAME`
WP_ADMIN_LOGIN=`cat /run/secrets/WP_ADMIN_LOGIN`
WP_ADMIN_PASSW=`cat /run/secrets/WP_ADMIN_PASSW`
WP_GUEST_LOGIN=`cat /run/secrets/WP_GUEST_LOGIN`
WP_GUEST_PASSW=`cat /run/secrets/WP_GUEST_PASSW`

# cp /var/wp/wordpress/wp-config-sample.php /var/wp/wordpress/wp-config-set.php

# sed -i "s/database_name_here/$WP_DB_NAME/" /var/wp/wordpress/wp-config-set.php
# sed -i "s/username_here/$WP_ADMIN_LOGIN/" /var/wp/wordpress/wp-config-set.php
# sed -i "s/password_here/$WP_ADMIN_PASSW/" /var/wp/wordpress/wp-config-set.php
# sed -i "s/localhost/db:9393/" /var/wp/wordpress/wp-config-set.php
# echo "$WP_DB_NAME/$WP_ADMIN_LOGIN/$WP_ADMIN_PASSW"

php /usr/local/bin/wp.phar --path=/var/wp/ plugin install redis-cache --activate --allow-root
# php /usr/local/bin/wp.phar --path=/var/wp/ plugin update --all --allow-root
# php /usr/local/bin/wp.phar --path=/var/wp/ redis enable --allow-root
# php /usr/local/bin/wp.phar --path=/var/wp/ core install --url="http://localhost" --title="Site Başlığı" --admin_user="$WP_ADMIN_LOGIN" --admin_password="$WP_ADMIN_PASSW" --admin_email="admin@example.com"
# php /usr/local/bin/wp.phar user create --path=/var/wp "$WP_GUEST_LOGIN" "guest42@42.fr" --user_pass="$WP_GUEST_PASSW"




#  php /usr/local/bin/wp.phar config set --path=/var/wp/ WP_CACHE true --raw
#  php /usr/local/bin/wp.phar config set --path=/var/wp/ WP_REDIS_PORT 6379 --raw
#  php /usr/local/bin/wp.phar config set --path=/var/wp/ WP_REDIS_HOST redis --raw
#  php /usr/local/bin/wp.phar config set --path=/var/wp/ WP_CACHE_KEY_SALT salt_localhost --raw
 
# cp /var/wp/wordpress/wp-config-set.php /var/wp/wordpress/wp-config.php
# rm /var/wp/wordpress/wp-config-set.php

# curl --data "user_name=$WP_ADMIN_LOGIN&admin_password=$WP_ADMIN_PASSW&admin_password2=$WP_ADMIN_PASSW&admin_email=username@email.addr&blog_public=checked&Submit=submit" "https://127.0.0.1/wordpress/wp-admin/install.php?step=2"

php-fpm83 -F
