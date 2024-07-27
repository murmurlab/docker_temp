sudo zypper install make docker-compose docker git

#!/bin/bash

# SSH portunu etkinleştir
sudo firewall-cmd --permanent --zone=public --add-port=22/tcp

# 80 ve 443 numaralı portları etkinleştir
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --permanent --zone=public --add-port=443/tcp

# Değişiklikleri uygula
sudo firewall-cmd --reload


systemctl start docker
systemctl enable docker
