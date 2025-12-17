#!/bin/bash

apt update
apt install apache2 -y

systemctl start apache2
systemctl enable apache2

mkdir -p /var/www/html/techsolutions

wget https://raw.githubusercontent.com/Chahinee777/TechSolutions-LandingPage/main/TechSolutions.html \
-O /var/www/html/techsolutions/index.html

chown -R www-data:www-data /var/www/html/techsolutions
chmod -R 755 /var/www/html/techsolutions

tee /etc/apache2/sites-available/techsolutions.conf > /dev/null <<EOF
<VirtualHost *:80>
ServerName techsolutions.local
DocumentRoot /var/www/html/techsolutions

<Directory /var/www/html/techsolutions>
AllowOverride All
Require all granted
</Directory>

ErrorLog \${APACHE_LOG_DIR}/techsolutions_error.log
CustomLog \${APACHE_LOG_DIR}/techsolutions_access.log combined
</VirtualHost>
EOF

a2ensite techsolutions.conf
a2dissite 000-default.conf

systemctl reload apache2

ip a
