#!/bin/sh
sed -i "s/^listen = 127.0.0.1/listen = $(getent hosts wp | awk '{ print $1 }')/" /etc/php83/php-fpm.d/www.conf

cp /var/wp/wordpress/wp-config-sample.php /var/wp/wordpress/wp-config-set.php

sed -i "s/database_name_here/$WP_DB_NAME/" /var/wp/wordpress/wp-config-set.php
sed -i "s/username_here/$WP_ADMIN_LOGIN/" /var/wp/wordpress/wp-config-set.php
sed -i "s/password_here/$WP_ADMIN_PASSW/" /var/wp/wordpress/wp-config-set.php
sed -i "s/localhost/db:9393/" /var/wp/wordpress/wp-config-set.php

cp /var/wp/wordpress/wp-config-set.php /var/wp/wordpress/wp-config.php
rm /var/wp/wordpress/wp-config-set.php

php-fpm83 -F