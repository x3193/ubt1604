#!/bin/bash
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

echo "--------------------------------------------" >> /root/cron.log;
sudo dpkg --configure -a
sudo apt-get autoremove -y ;
sudo apt-get clean -y ;
sudo apt-get autoclean -y ;
#pgrep scim-im-agent | xargs -I {} kill {}
pgrep ssh-agent | xargs -I {} kill {}
pgrep chromium-browse | xargs -I {} kill {}
echo "Clean ok!" >> /root/cron.log;

sudo chmod -R 7777 /var/www/html ;
echo "Chmod ok!" >> /root/cron.log;

sudo service apache2 restart ;
sudo service ssh start ;
sudo service mysql restart ;
sudo service cron restart ;
#sudo rm -rf -R /tmp/*
echo "Restart ok!" >> /root/cron.log;

 export LC_ALL='zh_CN.UTF-8' LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh:en_US:en'
 export DISPLAY=':1' AUTHORIZED_KEYS='**None**' ROOT_PASS='EUIfgwe7' TERM='xterm' INPUTRC='/etc/inputrc' APACHE_RUN_USER='www-data' APACHE_RUN_GROUP='www-data' APACHE_PID_FILE='/var/run/apache2/apache2.pid' APACHE_RUN_DIR='/var/run/apache2' APACHE_LOCK_DIR='/var/lock/apache2' APACHE_LOG_DIR='/var/log/apache2' 
 TZ='Asia/Shanghai'; export TZ
echo $(date) >> /root/cron.log;
echo "--------------------------------------------" >> /root/cron.log;