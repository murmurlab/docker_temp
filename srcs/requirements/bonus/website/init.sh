if [ ! -d "/var/www/resume/" ]; then
	curl -L -o /tmp/murmur.zip https://github.com/murmurlab/murmurlab.github.io/archive/refs/heads/main.zip
	mkdir -p /var/www/resume/
	unzip -o -d /var/www/resume /tmp/murmur.zip
	mv /var/www/resume/murmurlab.github.io-main/* /var/www/resume/
fi
npm start
