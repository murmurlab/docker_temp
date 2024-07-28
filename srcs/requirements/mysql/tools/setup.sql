CREATE DATABASE wp;
CREATE USER "wordpressusername"@"hostname" IDENTIFIED BY "password";
GRANT ALL PRIVILEGES ON wp.* TO "wordpressusername"@"hostname";
FLUSH PRIVILEGES;
EXIT;