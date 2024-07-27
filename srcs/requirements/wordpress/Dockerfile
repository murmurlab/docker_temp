FROM alpine:3.20

# EXPOSE 9000/tcp

RUN apk add --no-cache php83-fpm

# q mkdir /etc/nginx/sites-available

# COPY tools/default.conf /etc/nginx/http.d/default.conf
# COPY tools/nginx.conf etc/nginx/nginx.conf
# EXPOSE 9393
# VOLUME ["/var/db"]
CMD ["php-fpm83", "-F"] # build
# ENTRYPOINT ["php-fpm83 -F"] # this instruction prevent open interactive bash bc closing when executed this
# SHELL ["/bin/bash", "-c"]
