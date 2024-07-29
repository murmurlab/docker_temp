CREATE DATABASE wp;
CREATE USER "ahbasara"@"hostname" IDENTIFIED BY "deepthought";
GRANT ALL PRIVILEGES ON wp.* TO "ahbasara"@"hostname";
CREATE USER "guest42"@"hostname" IDENTIFIED BY "secret1234";
GRANT ALL PRIVILEGES ON wp.* TO "guest42"@"hostname";
FLUSH PRIVILEGES;
EXIT;