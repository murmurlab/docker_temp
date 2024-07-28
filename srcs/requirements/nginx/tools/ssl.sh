openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr -config openssl.cnf
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
