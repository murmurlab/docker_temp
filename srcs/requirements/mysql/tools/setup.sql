CREATE DATABASE wp;
CREATE USER ""@"hostname" IDENTIFIED BY "";
GRANT ALL PRIVILEGES ON wp.* TO ""@"hostname";
FLUSH PRIVILEGES;
EXIT;
