if [ ! -f /var/wp/adminer.php ]; then
	curl -L -o /var/wp/adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php
fi

php -S 0.0.0.0:8000 /var/wp/adminer.php
