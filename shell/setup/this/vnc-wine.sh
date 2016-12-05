#!/bin/bash

echo "---------------------pre-install-----------------------"  
echo "-----------------------configure-----------------------"
sudo dpkg --add-architecture i386
sudo dpkg --configure -a
sudo dpkg-reconfigure -p high -f noninteractive debconf 
sudo chmod -R 7777 /var/www/html/shell/conf 
#cat /proc/version
#uname -a
#lsb_release -a
echo "---------------------souce.list--------a---------------"  
cd /var/www/html/shell/conf/source
sudo cp -R -f /etc/apt/sources.list /etc/apt/sources.list.backup
if [ $1 = "trusty" ] || [ -z "$1" ] ; then
	sudo cp -R -f sources.list /etc/apt/sources.list
fi
if [ $1 = "xenial" ]; then
	sudo cp -R -f sources.list.xenial /etc/apt/sources.list
fi
if [ $1 = "utopic" ]; then
	sudo cp -R -f sources.list.utopic /etc/apt/sources.list
fi

#
sudo apt-get update --force-yes  -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y python-software-properties software-properties-common
sudo rm -rf -R /var/lib/apt/lists/*
sudo dpkg --add-architecture i386
sudo dpkg --configure -a
sudo dpkg-reconfigure -p high -f noninteractive debconf 
sudo apt-get install -f
sudo apt-get update --force-yes  -y
#sudo apt-get upgrade --force-yes  -y 
#sudo apt-get dist-upgrade --force-yes  -y
sudo apt-get autoremove -y  
sudo apt-get clean -y  
sudo apt-get autoclean -y 
echo "---------------------zh-cn-----------------------"  
cd /var/www/html/shell/conf 
##sudo echo "export LC_ALL='zh_CN.UTF-8' LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh:en_US:en'" >> ~/.profile
sudo echo "export LC_ALL='zh_CN.UTF-8' LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh:en_US:en'" >> /etc/profile
sudo echo "TZ='Asia/Shanghai'; export TZ" >> ~/.profile
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y language-pack-zh-hant language-pack-zh-hans language-pack-zh-hans-base language-pack-zh-hant-base language-pack-gnome-zh-hant ttf-ubuntu-font-family fonts-wqy-microhei
sudo mkdir -vp /usr/share/fonts/xpfonts
cd /var/www/html/shell/conf 
sudo cp -R -f /ttf/*.ttf /usr/share/fonts/xpfonts
sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv
echo "---------------------------SSH-----------------"  
cd /var/www/html/shell/conf 
sudo rm -rf ~/.ssh
mkdir -vp ~/.ssh
#ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""
cd /var/www/html/shell/conf/.ssh 
sudo cp -R -f known_hosts id_rsa.pub id_rsa authorized_keys default.ppk ~/.ssh 
sudo chmod -R 0600 ~/.ssh 
sudo chmod 0700 ~ 
sudo chmod 0700 ~/.ssh 
sudo chmod 0644 ~/.ssh/authorized_keys 
sudo mkdir -vp ~/ssh
sudo cp -R -f ~/.ssh/* ~/ssh
cd /var/www/html/shell/conf/ssh 
sudo cp -R -f ssh /etc/init.d 
echo "================================================="
#sudo service ssh start 
echo "================================================="
echo "---------------------crontab-----------------------"  
cd /var/www/html/shell/conf/cron
sudo cp -R -f crontab /etc 
#sed -i "s/\#\*\/1 \* \* \* \*/\*\/1 \* \* \* \*/g" /etc/crontab;
#sudo cp -R -f cron_hourly.sh /etc/cron.hourly 
#sudo cp -R -f cron_daily.sh /etc/cron.daily 
echo "================================================="
#sudo /etc/init.d/cron restart 
#sudo cron  
#sudo /etc/init.d/cron restart 
echo "================================================="
echo "---------------------proxy-----------------------" 
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y proxychains expect dnsutils
#sudo echo "socks5 127.0.0.1 9999" >> /etc/proxychains.conf
cd /var/www/html/shell/conf/Proxychains
sudo mkdir -vp /root/Desktop/Proxychains
sudo cp -R -f *.desktop /root/Desktop/Proxychains
sudo cp -R -f proxychains.conf /etc
echo "--------------------VNC------------------------"  
export LC_ALL='zh_CN.UTF-8' LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh:en_US:en'
#sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y novnc websockify openssl xorg ubuntu-gnome-desktop xfce4 icewm lxde tightvncserver x11vnc autocutsel git 
if [ $1 = "trusty" ] || [ -z "$1" ] ; then
	sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y novnc websockify openssl xorg xfce4 icewm lxde tightvncserver x11vnc autocutsel git 
fi
if [ $1 = "xenial" ]; then
	sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y novnc websockify openssl xorg icewm lxde tightvncserver x11vnc autocutsel git 
fi
##openssl req -x509 -nodes -newkey rsa:2048 -keyout /root/novnc.pem -out /root/novnc.pem -days 36500
cd /var/www/html/shell/conf/vncserver
sudo chmod -R 7777 /var/www/html/shell/conf
#sudo find /var/www/html/shell/conf/* -name noVNC-master.zip -delete 
#sudo wget -O noVNC-master.zip https://codeload.github.com/x3193/noVNC/zip/master
sudo mkdir -vp /var/www/html
sudo chmod -R 7777 /var/www/html
sudo unzip -o -d /var/www/html/ noVNC-master.zip
sudo chmod -R 7777 /var/www/html
sudo unzip -o -d /var/www/html/noVNC-master/utils websockify.zip
sudo cp -f novnc.pem /root
sudo ln -s /usr/share/novnc /var/www/html
sudo mkdir -vp /root/.vnc
sudo chmod -R 7777 /root/.vnc
cd /var/www/html/shell/conf/vncserver 
sudo cp -R -f passwd xstartup /root/.vnc 
sudo chmod -R 0600 /root/.vnc/passwd
tightvncserver :1
DISPLAY=:1 sudo add-apt-repository ppa:ondrej/php -y
#DISPLAY=:1 sudo add-apt-repository ppa:malcscott/shellinabox -y
#DISPLAY=:1 sudo add-apt-repository ppa:chris-lea/node.js -y
tightvncserver -kill :1
echo "================================================="
if [ -z "$1" ]; then
 tightvncserver -kill :1
 tightvncserver :1
 websockify -D --web=/usr/share/novnc/ --cert=/root/novnc.pem 6080 localhost:5901 & 
 #setsid /var/www/html/noVNC-master/utils/launch.sh --vnc localhost:5901 & 
fi 
echo "================================================="
if [ $2 = "wine" ] || [ -z "$2" ] ; then
echo "--------------------WINE1.6/8------------------------"  
sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep --install-recommends --force-yes -y wine1.6
sudo dpkg --add-architecture i386
sudo dpkg --configure -a
sudo dpkg-reconfigure -p high -f noninteractive debconf 
sudo apt-get install -f
sudo apt-get update --force-yes  -y
#sudo apt-get upgrade --force-yes  -y 
#sudo apt-get dist-upgrade --force-yes  -y 
sudo apt-get autoremove -y  
sudo apt-get clean -y  
sudo apt-get autoclean -y 
dpkg --print-architecture
dpkg --print-foreign-architectures
sudo dpkg --add-architecture i386
sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep --install-recommends --force-yes -y wine1.6
sudo dpkg --add-architecture i386
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y wine1.6
# wine32
#sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep --install-recommends --force-yes -y q4wine
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y q4wine
#env WINEARCH=win32 WINEPREFIX=~/.wine winecfg
#env WINEARCH=win64 WINEPREFIX=~/.wine64 winecfg
fi
echo "------------------------soft-------------------"  
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y firefox flashplugin-installer firefox-locale-zh-hant firefox-locale-zh-hans putty filezilla* dosbox putty visualboyadvance visualboyadvance-gtk libreoffice libreoffice-l10n-zh-cn pinta htop aptitude locate xchm fceux zsnes chromium-browser pepperflashplugin-nonfree
echo "CHROMIUM_FLAGS='--user-data-dir'" >> /etc/chromium-browser/default
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y lxtask lxsession-edit lxappearance lxappearance-obconf uget
echo "------------------------rarlinux--------------------" 
cd /var/www/html/shell/conf/
sudo mkdir -vp /var/www/html/shell/conf/rarlinux
cd /var/www/html/shell/conf/rarlinux
#sudo curl -o rarlinux-x64-5.3.0.tar.gz  http://www.rarsoft.com/rar/rarlinux-x64-5.3.0.tar.gz
sudo tar xvfz rarlinux-x64-5.3.0.tar.gz 
cd /var/www/html/shell/conf/rarlinux/rar
sudo mkdir -vp /usr/local/bin
sudo mkdir -vp /usr/local/lib
sudo cp -R -f rar unrar /usr/local/bin
sudo cp -R -f rarfiles.lst /etc
sudo cp -R -f default.sfx /usr/local/lib
echo "---------------------input-----------------------"  
#
sudo apt-get remove ibus -y
sudo apt-get autoremove -y  
sudo apt-get clean -y  
sudo apt-get autoclean -y
#
export LC_ALL='zh_CN.UTF-8' LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh:en_US:en'
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y scim
sudo dpkg --add-architecture i386
sudo dpkg --configure -a
sudo dpkg-reconfigure -p high -f noninteractive debconf 
sudo apt-get install -f
sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y scim-pinyin scim-tables-zh
sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv
#
echo "------------------------Clean--------------------"  
sudo apt-get autoremove -y  
sudo apt-get clean -y  
sudo apt-get autoclean -y  
echo "--------------------------------------------"  
