#!/bin/bash

echo "---------------------update-----------------------"  ;
rm -rf /var/lib/apt/lists/*;
sudo dpkg --add-architecture i386
sudo dpkg --configure -a
sudo dpkg-reconfigure -p high -f noninteractive debconf 
sudo apt-get install -f
sudo apt-get update --force-yes  -y
sudo apt-get upgrade --force-yes  -y 
sudo apt-get dist-upgrade --force-yes  -y
sudo apt-get autoremove -y  
sudo apt-get clean -y  
sudo apt-get autoclean -y 
echo "---------------------------php-----------------"  
#
tightvncserver :1
if [ $1 = "trusty" ] || [ -z "$1" ] ; then
 #sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep -y firefox putty htop unrar-free zip unzip git wget vim supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt php5-gd php5-curl php5-xdebug phpmyadmin -y  
 DISPLAY=:1 sudo DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y zip unzip git wget vim supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt php5-gd php5-curl php5-dev phpmyadmin gnome-schedule
fi
if [ $1 = "xenial" ]; then
 #sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep -y firefox putty htop unrar-free zip unzip git wget vim supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt php5-gd php5-curl php5-xdebug phpmyadmin -y  
 DISPLAY=:1 sudo DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y zip unzip git wget vim supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apcu php5-mcrypt php5-gd php5-curl php5-dev phpmyadmin 
fi
if [ $1 = "utopic" ] || [ -z "$1" ] ; then
 #sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep -y firefox putty htop unrar-free zip unzip git wget vim supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt php5-gd php5-curl php5-xdebug phpmyadmin -y  
 DISPLAY=:1 sudo DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y zip unzip git wget vim supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt php5-gd php5-curl php5-dev phpmyadmin
fi
tightvncserver -kill :1
#
sudo service apache2 restart  
sudo service mysql restart  
sudo cp -f -R /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.backup
sudo rm -rf /etc/php5/apache2/php.ini
#sudo cp -f -R /var/www/html/shell/conf/php/php.ini /etc/php5/apache2
sudo ln -s /var/www/html/shell/conf/php/php.ini /etc/php5/apache2
#sed -i "s/;opcache.enable=.*/opcache.enable=1/g" /etc/php5/apache2/php.ini
sudo php5enmod opcache ;
sudo php5enmod mcrypt ;
echo "ServerName localhost" >> /etc/apache2/apache2.conf 
chmod -R 7777 /var/www/html 
sudo a2enmod rewrite
sudo /etc/init.d/apache2 restart 
#
tightvncserver :1
DISPLAY=:1 sudo DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y --install-recommends libapache2-mod-php7.0 php7.0-curl;
tightvncserver -kill :1
#
sudo a2dismod php5
sudo a2enmod php7.0
sudo service apache2 restart;
sudo a2dismod php7.0
sudo a2enmod php5
sudo service apache2 restart;
#
echo "---------------------filemanager-----------------------"  
sudo chmod -R 7777 /var/www/html 
sudo find /var/www/html -name index.html -delete 
cd /var/www/html/shell/conf/php 
sudo cp -f .htaccess filebox.php diy.php index.php /var/www/html 
cd /var/www/html/shell/conf/dns
sudo cp -f 000-default.conf /etc/apache2/sites-available  
sudo service apache2 restart  
#sudo cp -f /var/www/html/filebox.php /var/www/html/index.php 
echo "--------------------DNS------------------------"  
cd /var/www/html/shell/conf/dns 
sudo mkdir -vp /var/www/html/dz32
sudo chmod -R 7777 /var/www/html/dz32
sudo cp -f *.*.conf /etc/apache2/sites-available  
cd /
sudo find /etc/apache2/sites-available/ -name '*.conf' -exec sudo ln -s {} /etc/apache2/sites-enabled/  \;
sudo service apache2 restart 
#sed -i "s/<\/VirtualHost>.*/\r\n\r\nProxyRequests Off\r\n<proxy *>\r\nOrder allow\,deny\r\nAllow from all\r\n<\/proxy>\r\n\r\n<\/VirtualHost>/g" /etc/apache2/sites-available/000-default.conf;
echo "--------------------mysql------------------------"  
cd /var/www/html/shell/conf/mysql 
sudo cp -R -f /var/lib/mysql/my.cnf /var/lib/mysql/my.cnf.backup
#sudo rm -rf /var/lib/mysql/my.cnf
#sudo cp -f my.cnf /var/lib/mysql 
#sed -i "s/bind-address/#bind-address/g" /var/lib/mysql/my.cnf
sed -i "s/bind-address/#bind-address/g" /etc/mysql/my.cnf
sudo service mysql restart  
sudo /usr/bin/mysqladmin -u root password 'EUIfgwe7' 
sudo service mysql restart 
cd /var/lib 
sudo tar xvfz /var/www/html/shell/conf/mysql/mysql.tar.gz
#
#cd /var/www/html/shell/conf/mysql 
#sudo tar xvfz ./mysql.tar.gz
#sudo cp -R -f mysql /var/lib
sudo service apache2 restart  
sudo service mysql restart  
echo "--------------------phpmyadmin-----------------------"  
cd /var/www/html
sudo ln -s /usr/share/phpmyadmin phpmyadmin 
sudo chmod -R 7777 /usr/share/phpmyadmin 
cd /var/www/html/shell/conf/php
sudo cp -f Config.class.php /usr/share/phpmyadmin/libraries 
sudo cp -f diy.php /usr/share/phpmyadmin 
sudo php5enmod mcrypt
sudo service apache2 restart 
echo "--------------------novnc-----------------------"
cd /var/www/html
sudo cp -f /var/www/html/vnc.html /var/www/html/noVNC-master/vnc_auto.html
cd /var/www/html/shell/conf/php
sudo chmod -R 7777 /var/www/html/noVNC-master
#rm -rf /var/www/html/noVNC-master/vnc.html
#rm -rf /var/www/html/noVNC-master/vnc_auto.html
sudo cp -f vnc.php /var/www/html/noVNC-master/index.php 
sudo cp -f diy.php /var/www/html/noVNC-master 
sudo touch /var/www/html/noVNC-master/vnc.html
sudo cp -f /var/www/html/noVNC-master/vnc.html /var/www/html/noVNC-master/vnc_auto.html
cd /var/www/html/shell/conf/php
sudo chmod -R 7777 /var/www/html/novnc
#rm -rf /var/www/html/novnc/vnc.html
#rm -rf /var/www/html/novnc/vnc_auto.html
sudo cp -f vnc.php /var/www/html/novnc/index.php 
sudo cp -f diy.php /var/www/html/novnc
cd /var/www/html/shell/conf/vncserver
sudo cp -f novnc.pem /root
chmod -R 7777 /var/www/html
#sed -i "s/<\/proxy>.*/<\/proxy>\r\nProxyPass \/novnc http\:\/\/localhost\:6080\/  \r\nProxyPassReverse \/novnc http\:\/\/localhost\:6080\/\r\n/g" /etc/apache2/sites-available/000-default.conf;
sudo mkdir -vp /home/www-data
sudo chmod -R 7777 /home/www-data
cd /root
sudo cp -R -f ./.vnc /home/www-data
sudo chmod -R 0600 /home/www-data/.vnc/passwd 
echo "www-data:$ROOT_PASS" | chpasswd
sed -i "s/www-data:x:.*/www-data:x:33:0:www-data:\/home\/www-data:\/bin\/bash/g" /etc/passwd
echo "--------------------php-shell-----------------------"  
cd /var/www/html/shell/conf/php
#sudo cp -R -f /etc/sudoers /etc/sudoers.backup
echo "www-data ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "Defaults visiblepw" >> /etc/sudoers
cd /var/www/html/shell/conf/php-shell
sudo chmod -R 7777 /var/www/html/shell/conf 
sudo find /var/www/html/shell/conf/* -name b374k-master.zip -delete 
sudo wget -O b374k-master.zip https://codeload.github.com/x3193/b374k/zip/master
sudo chmod -R 7777 /var/www/html
sudo unzip -o -d /var/www/html/ b374k-master.zip
echo "--------------------USER--------------------------------" 
adduser --shell /bin/bash --system --ingroup root --force-badname --uid 1001 x3193
echo "x3193 ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
PASS=${ROOT_PASS:-$(pwgen -s 12 1)}
echo "x3193:$PASS" | chpasswd
echo "www-data:$PASS" | chpasswd
echo "---------------------tty.js---------------------------"
#
sudo DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y --install-recommends nodejs npm
ln -s /usr/bin/nodejs /usr/bin/node -f
#
sudo npm install -g node-gyp n
node -v
sudo n 4.3.0
node -v
npm -v
sudo npm update -g
npm -v
sudo npm install -g node-gyp
sudo npm install -g tty.js n
#
cd /var/www/html/shell/conf/node.js/tty.js
sudo cp -R -f tty.js .tty.js /usr/local/lib/node_modules/tty.js
cd /usr/local/lib/node_modules/tty.js
#openssl req -x509 -newkey rsa:2048 -keyout ./key.pem -out ./cert.pem -days 36500 -nodes
cd /var/www/html/shell/conf/vncserver
sudo cp -f key.pem cert.pem /usr/local/lib/node_modules/tty.js
#sed -i "s/<\/proxy>.*/<\/proxy>\r\nProxyPass \/tty\.js http\:\/\/localhost\:8000\/  \r\nProxyPassReverse \/tty\.js http\:\/\/localhost\:8000\/\r\n/g" /etc/apache2/sites-available/000-default.conf;
#
cd /usr/local/lib/node_modules/node-gyp
sudo npm install
ln -s /usr/local/lib/node_modules /root/node.js -f
sudo mkdir -vp /var/www/html/tty.js
#sudo npm update -g
#sudo npm search xterm
#npm config get prefix
#
echo "---------------------ajaxterm-----------------------"  
sudo apt-get install ajaxterm -y
echo "setsid ajaxterm" >> /var/www/html/shell/loader/this/vnc.sh
sudo sed -i "s/PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config;
sudo service ssh start;
sudo a2enmod proxy_http;
sed -i "s/Listen 80/Listen 80 \r\nListen 8022/g" /etc/apache2/ports.conf;
sed -i "s/<\/VirtualHost>.*/<\/VirtualHost>\r\n\r\n<VirtualHost \*\:8022>\r\nProxyRequests Off\r\n<proxy *>\r\nOrder allow\,deny\r\nAllow from all\r\n<\/proxy>\r\nProxyPass \/ http\:\/\/localhost\:8022\/  \r\nProxyPassReverse \/ http\:\/\/localhost\:8022\/\r\n<\/VirtualHost>/g" /etc/apache2/sites-available/000-default.conf;
#sed -i "s/ServerName www-x3193.myalauda.cn.*/ServerName localhost/g" /etc/apache2/sites-available/000-default.conf;
cat /etc/apache2/ports.conf;
cat /etc/apache2/sites-available/000-default.conf;
sudo service apache2 restart;
sudo mkdir -vp /var/www/html/ajaxterm
echo "--------------------shellinabox-------------------------"
#sudo add-apt-repository ppa:malcscott/shellinabox -y
#sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y shellinabox
echo "---------------------c ide---------------------------"
#
sudo DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y --install-recommends geany geany* 
#
sudo DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y --install-recommends mcu8051ide as31 emu8051 dis51 cycfx2prog
echo "------------------------Clean--------------------"  ;
sudo apt-get autoremove -y  ;
sudo apt-get clean -y  ;
sudo apt-get autoclean -y  ;
echo "--------------------------------------------"  ;
