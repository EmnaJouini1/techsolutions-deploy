#!/bin/bash

echo "==============================="
echo " Déploiement TechSolutions"
echo "==============================="

# 1️⃣ Mise à jour du système
sudo apt update -y

# 2️⃣ Installation d'Apache
sudo apt install apache2 -y

# 3️⃣ Démarrage et activation d'Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# 4️⃣ Création du dossier du site
sudo mkdir -p /var/www/html/techsolutions

# 5️⃣ Téléchargement du site depuis GitHub
sudo wget https://raw.githubusercontent.com/Chahinee777/TechSolutions-LandingPage/main/TechSolutions.html \
-O /var/www/html/techsolutions/index.html

# 6️⃣ Permissions correctes pour Apache
sudo chown -R www-data:www-data /var/www/html/techsolutions
sudo chmod -R 755 /var/www/html/techsolutions

# 7️⃣ Création du VirtualHost
sudo tee /etc/apache2/sites-available/techsolutions.conf > /dev/null <<EOF
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

# 8️⃣ Activation du site et désactivation du site par défaut
sudo a2ensite techsolutions.conf
sudo a2dissite 000-default.conf

# 9️⃣ Reload Apache
sudo systemctl reload apache2

# 🔟 Affichage IP pour accéder au site
echo ""
echo "==============================="
echo " Site déployé avec succès ✅"
echo " Accès au site via :"
ip a | grep inet | grep -v 127.0.0.1
echo ""
echo "URL à utiliser : http://IP_DE_LA_VM"
echo "==============================="
