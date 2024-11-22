FROM alpine:3.19

RUN apk add --no-cache redis
COPY redis.conf /etc/redis.conf
COPY object-cache.php /var/wp/wp-content/

# EXPOSE 6379
CMD redis-server --protected-mode no

# RUN apt-get install redis-server php5-redis
# RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
#   && pecl install redis \
#   && docker-php-ext-enable redis \
#   && apk del pcre-dev ${PHPIZE_DEPS} \
#   && rm -rf /tmp/pear

