FROM alpine:3.20

# EXPOSE 9000/tcp

RUN apk add --no-cache php83-fpm php83-mysqli
EXPOSE 9000/tcp
# q mkdir /etc/nginx/sites-available

# COPY tools/default.conf /etc/nginx/http.d/default.conf
COPY tools/www.conf /etc/php83/php-fpm.d/www.conf
COPY tools/fix.sh /fix.sh
# RUN sh /fix.sh
# EXPOSE 9393
# VOLUME ["/var/db"]
CMD ["sh", "/fix.sh"] # build
# ENTRYPOINT ["php-fpm83 -F"] # this instruction prevent open interactive bash bc closing when executed this
# SHELL ["/bin/bash", "-c"]
