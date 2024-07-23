FROM alpine:3.20
RUN apk add --no-cache nginx

# COPY tools/mysql.cnf etc/my.cnf.d/mariadb-server.cnf
# RUN mkdir -p /var/db/mariadbd
# RUN chmod -R 777 /var/db/mariadbd
# RUN mysql_install_db --user=mysql
# --basedir=/usr --datadir=/var/db/mariadbd/
# EXPOSE 9393
# VOLUME ["/var/db"]
# CMD [ "mariadbd-safe"] # build
# ENTRYPOINT ["mariadbd-safe"] # this instruction prevent open interactive bash bc closing when executed this
# SHELL ["/bin/bash", "-c"]
