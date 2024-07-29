db_ip=$(getent hosts db | awk '{ print $1 }')
wp_ip=$(getent hosts wp | awk '{ print $1 }')

cat <<EOF
CREATE DATABASE wp;
CREATE USER "$WP_ADMIN_LOGIN"@"$wp_ip" IDENTIFIED BY "$WP_ADMIN_PASSW";
GRANT ALL PRIVILEGES ON wp.* TO "$WP_ADMIN_LOGIN"@"$wp_ip";
CREATE USER "$WP_GUEST_LOGIN"@"$wp_ip" IDENTIFIED BY "$WP_GUEST_PASSW";
GRANT ALL PRIVILEGES ON wp.* TO "$WP_GUEST_LOGIN"@"$wp_ip";
FLUSH PRIVILEGES;
EOF