#!/bin/bash
# This script is to install PHP 7.0 to Ubuntu12.04 & Ubuntu14.04
# WARNINGS! This only for Ubuntu!

# Adding a PPA for PHP7.0 Packages
add-apt-repository ppa:ondrej/php
apt-get update
    
# Install Nginx and PHP7
apt-get install -y php7.0-fpm php7.0-cli php7.0-gd php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-readline php7.0-xml

# Setting the PHP5
#mkdir -p /home/log
#touch /home/log/php-fpm.log

# Setting the php-fpm.conf
if [ ! -f /etc/php/7.0/fpm/php-fpm.conf.default ]; then
    cp /etc/php/7.0/fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf.default
fi
#sed -i 's/var\/log\/php7.0-fpm.log/home\/log\/php7.0-fpm.log/g' /etc/php5/fpm/php-fpm.conf

# Setting the php.ini
if [ ! -f /etc/php/7.0/fpm/php.ini.default ]; then
    cp /etc/php/7.0/fpm/php.ini /etc/php/7.0/fpm/php.ini.default
fi
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/7.0/fpm/php.ini
sed -i 's/expose_php = On/expose_php = Off/g' /etc/php/7.0/fpm/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 128M/g' /etc/php/7.0/fpm/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.0/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 64M/g' /etc/php/7.0/fpm/php.ini
sed -i 's/;date.timezone =/date.timezone = "Asia\/Taipei"/g' /etc/php/7.0/fpm/php.ini

# Setting the php-fpm.conf
sed -i 's/;emergency_restart_threshold = 0/emergency_restart_threshold = 10/g' /etc/php/7.0/fpm/php-fpm.conf
sed -i 's/;emergency_restart_interval = 0/emergency_restart_interval = 1m/g' /etc/php/7.0/fpm/php-fpm.conf
sed -i 's/;process_control_timeout = 0/process_control_timeout = 10s/g' /etc/php/7.0/fpm/php-fpm.conf

# Setting the www.conf
if [ ! -f /etc/php/7.0/fpm/pool.d/www.conf.default ]; then
    cp /etc/php/7.0/fpm/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf.default
fi
#sed -i 's/www-data/nginx/g' /etc/php5/fpm/pool.d/www.conf

# Setting logrotate
if [ ! -d /root/defaultfile ]; then
    mkdir -p /root/defaultfile
fi

if [ -f /etc/logroate.d/php7.0-fpm ]; then
    mv /etc/logroate.d/php7.0-fpm /root/defaultfile/etc.logroate.d.php7.0-fpm
fi
cp etc.logrotate.d.php7.0-fpm /etc/logrotate.d/php7.0-fpm
