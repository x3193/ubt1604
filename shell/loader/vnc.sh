#!/bin/bash

echo "--------------------VNC------------------------" 

sudo cron
sudo rm -rf -R /tmp/*

export LC_ALL='zh_CN.UTF-8' LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh:en_US:en'
TZ='Asia/Shanghai'; export TZ
tightvncserver :1
setsid /var/www/html/noVNC-master/utils/launch.sh --vnc localhost:5901 &

echo "--------------------VNC------------------------"