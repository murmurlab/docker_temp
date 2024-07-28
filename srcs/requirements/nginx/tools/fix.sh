#!/bin/sh
sed -i "s/server 127.0.0.1/server $(getent hosts wordpress | awk '{ print $1 }')/" /etc/nginx/http.d/default.conf
nginx