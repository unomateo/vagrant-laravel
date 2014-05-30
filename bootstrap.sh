#! /usr/bin/env bash

# Update the server
apt-get update

# install vim and git
sudo apt-get install -y vim git curl mcrypt

# install apache2
apt-get install -y apache2

# install php5
sudo apt-get install -y libapache2-mod-php5
#apt-get install -y python-software-properties
apt-get install -y php5 php5-mcrypt php5-mysql php5-curl

# remove default web folder
rm -rf /var/www

# symlink vagrant to web folder
ln -fs /vagrant /var/www

# install composer
sudo curl -sS https://getcomposer.org/installer | sudo php -- --filename=composer --install-dir=/usr/local/bin

# install laravel
# composer create-project laravel/laravel laravel --prefer-dist

# apache directives
# echo "ServerName localhost" > /etc/apache2/httpd.conf

# set up host file
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/vagrant/laravel/public"
  ServerName localhost
  <Directory "/vagrant/laravel/public">
    AllowOverride All
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/laravel.conf

# enable rewrite
a2enmod rewrite

# restart apache
service apache2 restart

# install mysql
#export DEBIAN_FRONTEND=noninteractive
#apt-get install -q -y mysql-server-5.5


