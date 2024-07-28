FROM alpine:3.20

EXPOSE 80/tcp
EXPOSE 443/tcp
#  TLSv1.2 or TLSv1.3 =========================
RUN apk add --no-cache nginx
# RUN mkdir /etc/nginx/sites-available

RUN apk add git; git clone https://github.com/murmurlab/murmurlab.github.io.git var/wp/test-site

COPY tools/default.conf /etc/nginx/http.d/default.conf
COPY tools/nginx.conf etc/nginx/nginx.conf
COPY tools/fix.sh /fix.sh
# EXPOSE 9393
# VOLUME ["/var/db"]
# CMD [ "mariadbd-safe"] # build
ENTRYPOINT ["sh", "/fix.sh"] # this instruction prevent open interactive bash bc closing when executed this
# SHELL ["/bin/bash", "-c"]
