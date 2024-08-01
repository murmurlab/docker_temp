FROM alpine:3.19

EXPOSE 9000/tcp

RUN apk add --no-cache php83-fpm php83-mysqli curl mysql-client
# EXPOSE 9000/tcp
# q mkdir /etc/nginx/sites-available

RUN curl -L -o /tmp/murmur.zip https://github.com/murmurlab/murmurlab.github.io/archive/refs/heads/main.zip
RUN unzip -o -d /var/wp/ /tmp/murmur.zip
RUN curl -L -o /tmp/latest.zip https://wordpress.org/latest.zip
RUN unzip -o -d /var/wp /tmp/latest.zip
# COPY tools/default.conf /etc/nginx/http.d/default.conf
COPY tools/www.conf /etc/php83/php-fpm.d/www.conf
COPY tools/fix.sh /fix.sh
# RUN sh /fix.sh
# EXPOSE 9393
# VOLUME ["/var/db"]
CMD ["sh", "/fix.sh"] # build
# ENTRYPOINT ["php-fpm83 -F"] # this instruction prevent open interactive bash bc closing when executed this
# SHELL ["/bin/bash", "-c"]
