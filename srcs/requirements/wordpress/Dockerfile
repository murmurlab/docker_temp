FROM alpine:3.19

EXPOSE 9000/tcp

RUN apk add --no-cache php83-fpm
RUN apk add --no-cache php83-mbstring
RUN apk add --no-cache php83-mysqli
RUN apk add --no-cache curl
RUN apk add --no-cache mysql-client
RUN apk add --no-cache php83-phar
RUN apk add --no-cache php83-tokenizer
# EXPOSE 9000/tcp
# q mkdir /etc/nginx/sites-available

RUN curl -o /usr/local/bin/wp.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /usr/local/bin/wp.phar

RUN ln -s /usr/bin/php83 /usr/bin/php

# RUN PATH=/usr/bin/php/8.3/bin:$PATH
RUN curl -L -o /tmp/murmur.zip https://github.com/murmurlab/murmurlab.github.io/archive/refs/heads/main.zip
RUN unzip -o -d /var/wp/ /tmp/murmur.zip
RUN curl -L -o /tmp/latest.zip https://wordpress.org/latest.zip
RUN unzip -o -d /var/wp /tmp/latest.zip
RUN mv var/wp/wordpress/* var/wp/
RUN rm -r var/wp/wordpress

# RUN php /usr/local/bin/wp.phar core download --path=/var/wp/wordpress/
# RUN rm -f /var/wp/wordpress/wp-config.php
# RUN cp /var/wp/wordpress/wp-config-sample.php /var/wp/wordpress/wp-config.php
RUN --mount=type=secret,id=WP_ADMIN_LOGIN \
	--mount=type=secret,id=WP_ADMIN_PASSW  \
	--mount=type=secret,id=WP_DB_NAME  \
	--mount=type=secret,id=WP_GUEST_LOGIN  \
	--mount=type=secret,id=WP_GUEST_PASSW  \
	WP_ADMIN_LOGIN="$(cat /run/secrets/WP_ADMIN_LOGIN)" && \
	WP_ADMIN_PASSW="$(cat /run/secrets/WP_ADMIN_PASSW)" && \
	WP_DB_NAME="$(cat /run/secrets/WP_DB_NAME)" && \
	WP_GUEST_LOGIN="$(cat /run/secrets/WP_GUEST_LOGIN)" && \
	WP_GUEST_PASSW="$(cat /run/secrets/WP_GUEST_PASSW)" && \
	echo "$WP_ADMIN_LOGIN""-""$WP_ADMIN_PASSW""-""$WP_DB_NAME" && \
	# php /usr/local/bin/wp config create && \
	# php /usr/local/bin/wp config set --config-file=/var/wp/wordpress/wp-config.php DB_NAME "$WP_DB_NAME" && \
	# php /usr/local/bin/wp config set --config-file=/var/wp/wordpress/wp-config.php DB_USER "$WP_ADMIN_LOGIN" && \
	# php /usr/local/bin/wp config set --config-file=/var/wp/wordpress/wp-config.php DB_PASSWORD "$WP_ADMIN_PASSW" && \
	# php /usr/local/bin/wp config set --config-file=/var/wp/wordpress/wp-config.php DB_HOST "db:9393"
	if [ ! -f ok ]; then \
	php /usr/local/bin/wp.phar config create --path=/var/wp/ --dbname="$WP_DB_NAME" --dbuser="$WP_ADMIN_LOGIN" --dbpass="$WP_ADMIN_PASSW" --dbhost="db:9393" --dbprefix="wp_" --skip-check --force && cat /var/wp/wp-config.php && \
	php /usr/local/bin/wp.phar config set --path=/var/wp/ WP_CACHE true --raw && \
	php /usr/local/bin/wp.phar --path=/var/wp/ config set WP_REDIS_HOST redis --allow-root && \
	php /usr/local/bin/wp.phar --path=/var/wp/ config set WP_REDIS_PORT 6379 --raw --allow-root && \
	php /usr/local/bin/wp.phar --path=/var/wp/ config set WP_CACHE_KEY_SALT salt_localhost --allow-root && \
	php /usr/local/bin/wp.phar --path=/var/wp/ config set WP_REDIS_CLIENT phpredis --allow-root && \
	touch ok; \
	fi
	# php /usr/local/bin/wp.phar core install --path=/var/wp --url="http://localhost" --title="Site Başlığı" --admin_user="$WP_ADMIN_LOGIN" --admin_password="$WP_ADMIN_PASSW" --admin_email="admin@example.com"

# COPY tools/default.conf /etc/nginx/http.d/default.conf
COPY tools/www.conf /etc/php83/php-fpm.d/www.conf
COPY tools/fix.sh /fix.sh




# RUN sh /fix.sh
# EXPOSE 9393
# VOLUME ["/var/db"]
CMD ["sh", "/fix.sh"] # build
# ENTRYPOINT ["php-fpm83 -F"] # this instruction prevent open interactive bash bc closing when executed this
# SHELL ["/bin/bash", "-c"]
