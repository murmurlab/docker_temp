FROM alpine:3.19

RUN apk --no-cache add nodejs npm curl
COPY ./src /sources/website
COPY ./init.sh /init.sh
WORKDIR /sources/website
RUN npm i

# RUN curl -L -o /tmp/murmur.zip https://github.com/murmurlab/murmurlab.github.io/archive/refs/heads/main.zip
# RUN mkdir -p /var/www/resume/
# RUN unzip -o -d /var/www/resume /tmp/murmur.zip

CMD sh /init.sh
