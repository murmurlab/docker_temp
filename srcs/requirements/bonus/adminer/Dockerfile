FROM alpine:3.19

# EXPOSE 8000

RUN apk --no-cache add curl php
RUN apk --no-cache add php-common
RUN apk --no-cache add php-session
RUN apk --no-cache add php-mysqli

COPY ./ctrl.sh /ctrl.sh

CMD sh ctrl.sh
