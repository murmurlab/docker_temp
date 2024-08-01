FROM alpine:3.19
RUN apk add --no-cache mysql mysql-client
# COPY tools/my.cnf /etc/my.cnf
COPY tools/mysql.cnf etc/my.cnf.d/mariadb-server.cnf
COPY tools/setup.sh /root/setup.sh
COPY tools/fix.sh /root/fix.sh
RUN mkdir -p /var/db/mariadbd
RUN chmod -R 777 /var/db/mariadbd
RUN mysql_install_db --user=mysql 
# RUN sh /root/fix.sh

# RUN cd /root && sh setup.sh && mysql <setup.sql
# --basedir=/usr --datadir=/var/db/mariadbd/
EXPOSE 9393
# VOLUME ["/var/db"]
# CMD [ "mariadbd-safe"] # build
ENTRYPOINT ["sh", "/root/fix.sh"] # this instruction prevent open interactive bash bc closing when executed this
# SHELL ["/bin/bash", "-c"]
