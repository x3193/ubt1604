#FROM ubuntu:xenial
#FROM ubuntu:trusty

#FROM x3193/ubt1404:ubuntu-trusty-vnc-wine-php-2016
#FROM daocloud.io/x3193/ops:latest

#ubt1604+vnc 
#FROM daocloud.io/x3193/ops:master-d92783e
#FROM daocloud.io/x3193/ubt1404:master-f3b1845
#ubt1604+vnc+php
#FROM daocloud.io/x3193/ops:master-b11e472
#FROM daocloud.io/x3193/ops:master-f3b1845
#ubt1404+vnc
FROM daocloud.io/x3193/ops:master-5303ce7
#ubt1404+vnc+php
#FROM daocloud.io/x3193/ops:master-efc0935

MAINTAINER x3193.usa.cc <x3193@x3193.usa.cc>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV USER root
ENV AUTHORIZED_KEYS **None**
ENV ROOT_PASS EUIfgwe7

RUN export DISPLAY=':1' AUTHORIZED_KEYS='**None**' ROOT_PASS='EUIfgwe7' TERM='xterm' INPUTRC='/etc/inputrc' APACHE_RUN_USER='www-data' APACHE_RUN_GROUP='www-data' APACHE_PID_FILE='/var/run/apache2/apache2.pid' APACHE_RUN_DIR='/var/run/apache2' APACHE_LOCK_DIR='/var/lock/apache2' APACHE_LOG_DIR='/var/log/apache2' TZ='Asia/Shanghai'; export TZ;dpkg --configure -a && apt-get install -f && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install expect sudo net-tools openssh-server pwgen zip unzip python-numpy python3-numpy cron curl git; mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config; sudo DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends --force-yes -y sudo net-tools wget vim zip unzip python-numpy python3-numpy cron curl; 
#RUN cd /root;sudo wget -O ubt1404.zip http://sf.x3193.usa.cc/docker/ubt1404.zip;sudo unzip -o -d /root/ ubt1404.zip;cd /root/ubt1404;sudo cp -R -f set_root_pw.sh run.sh /;sudo chmod -R 7777 /*.sh;sudo mkdir -vp /var/www/html;sudo cp -R -f shell /var/www/html;sudo chmod -R 7777 /var/www/html/shell;

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
ADD shell /var/www/html/shell
RUN chmod -R 7777 /*.sh;sudo mkdir -vp /var/www/html;chmod -R 7777 /var/www/html/shell

RUN sudo sh /var/www/html/shell/setup/this/vnc-wine.sh trusty "wine";
#RUN sudo sh /var/www/html/shell/setup/this/u7php.sh trusty; 

EXPOSE 22 80 6080 5901 5902 8080 2222 3377 4200 8022 8000

WORKDIR /root

#CMD /run.sh full dc
CMD /run.sh full
