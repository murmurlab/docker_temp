#!/bin/sh

sed -i "s/^listen = 127.0.0.1/listen = $(getent hosts $(hostname) | awk '{ print $1 }')/" /etc/php83/php-fpm.d/www.conf
echo $(getent hosts $(hostname) | awk '{ print $1 }') > aaaa

php-fpm83 -F