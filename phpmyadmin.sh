#!/usr/bin/env bash

phpmyadmin="/etc/phpmyadmin"
if [ -d "$phpmyadmin" ]
then
	echo "PHPMyAdmin already installed."
else
    DBPASSWD=root
    echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none" | debconf-set-selections
    apt-get -y install phpmyadmin > /dev/null 2>&1

    ## Additional PHP extension
    apt-get -y install php7.0-xml
    service apache2 restart
fi