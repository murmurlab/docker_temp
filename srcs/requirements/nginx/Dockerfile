FROM alpine:3.20

EXPOSE 80/tcp

RUN apk add --no-cache nginx
# RUN mkdir /etc/nginx/sites-available

COPY tools/default.conf /etc/nginx/http.d/default.conf
COPY tools/nginx.conf etc/nginx/nginx.conf
# EXPOSE 9393
# VOLUME ["/var/db"]
# CMD [ "mariadbd-safe"] # build
ENTRYPOINT ["nginx"] # this instruction prevent open interactive bash bc closing when executed this
# SHELL ["/bin/bash", "-c"]
