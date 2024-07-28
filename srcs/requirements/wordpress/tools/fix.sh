#!/bin/sh
sed -i "s/^listen = 127.0.0.1/listen = $(getent hosts $(hostname) | awk '{ print $1 }')/" /etc/php83/php-fpm.d/www.conf
php-fpm83 -F