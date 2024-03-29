#!/bin/bash
 
echo "--------------------VNC------------------------" 

bash
sudo cron &
sudo /etc/init.d/cron restart

sudo rm -rf -R /tmp/*
sudo chmod -R 7777 /var/www/html
cd /root

if [ $1 = "full" ]; then

 sudo service apache2 restart ;
 sudo service ssh start ;
 sudo service mysql restart ;
 export LC_ALL='zh_CN.UTF-8' LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh:en_US:en'
 export DISPLAY=':1' AUTHORIZED_KEYS='**None**' ROOT_PASS='EUIfgwe7' TERM='xterm' INPUTRC='/etc/inputrc' APACHE_RUN_USER='www-data' APACHE_RUN_GROUP='www-data' APACHE_PID_FILE='/var/run/apache2/apache2.pid' APACHE_RUN_DIR='/var/run/apache2' APACHE_LOCK_DIR='/var/lock/apache2' APACHE_LOG_DIR='/var/log/apache2' 
 TZ='Asia/Shanghai'; export TZ
 tightvncserver -kill :1
 tightvncserver :1
 setsid /var/www/html/noVNC-master/utils/launch.sh --vnc localhost:5901 &
 #websockify -D --web=/usr/share/novnc/ --cert=/root/novnc.pem 6080 localhost:5901 & 
fi

if [ $1 = "vnc" ]; then

 #sudo service apache2 restart ;
 #sudo service ssh start ;
 #sudo service mysql restart ;
 export LC_ALL='zh_CN.UTF-8' LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh:en_US:en'
 export DISPLAY=':1' AUTHORIZED_KEYS='**None**' ROOT_PASS='EUIfgwe7' TERM='xterm' INPUTRC='/etc/inputrc' APACHE_RUN_USER='www-data' APACHE_RUN_GROUP='www-data' APACHE_PID_FILE='/var/run/apache2/apache2.pid' APACHE_RUN_DIR='/var/run/apache2' APACHE_LOCK_DIR='/var/lock/apache2' APACHE_LOG_DIR='/var/log/apache2'
 TZ='Asia/Shanghai'; export TZ
 tightvncserver -kill :1
 tightvncserver :1
 setsid /var/www/html/noVNC-master/utils/launch.sh --vnc localhost:5901 &
 #websockify -D --web=/usr/share/novnc/ --cert=/root/novnc.pem 6080 localhost:5901 &
fi

if [ $1 = "php" ]; then
 sudo service apache2 restart ;
 #sudo service ssh start ;
 #sudo service mysql restart ;
fi

if [ $1 = "php-full" ]; then
 sudo service apache2 restart ;
 #sudo service ssh start ;
 sudo service mysql restart ;
fi

echo "--------------------VNC------------------------"