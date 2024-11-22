FROM alpine:3.19

RUN apk --no-cache add vsftpd
RUN adduser -D murmur42
# RUN addgroup wp-data
# RUN adduser murmur42 wp-data
# RUN chgrp -R wp-data /var/wp/wordpress/
RUN --mount=type=secret,id=WP_ADMIN_PASSW  \
	WP_ADMIN_PASSW="$(cat /run/secrets/WP_ADMIN_PASSW)" && \
	(echo "$WP_ADMIN_PASSW"; echo "$WP_ADMIN_PASSW";) | passwd murmur42

# ftp://murmur42@127.0.0.1:2121/

CMD [ ! -e /home/murmur42/wordpress ] && \
	ln -s /var/wp/wordpress /home/murmur42/wordpress; \
	chmod 777 -R /var/wp; \ 
	vsftpd \
	# -olocal_root=/var/wp/wordpress \
	-olisten_address=0.0.0.0 \
	-olisten_port=2121 \
	-olocal_enable=YES \
	-owrite_enable=YES \
	-ochroot_local_user=YES \
	-oallow_writeable_chroot=YES \
	# -ochmod_enable=YES \
	# -ouser_sub_token=$USER/wordpress \
	-olocal_root=/var/wp \
	-oseccomp_sandbox=NO
