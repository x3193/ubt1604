#!/bin/bash

echo "--------------------WINE1.6/8------------------------"  ;
sudo dpkg --configure -a;
sudo apt-get dist-upgrade -y ;
sudo apt-get update -y;
sudo apt-get upgrade -y ;
sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep -y --force-yes wine1.6;
sudo dpkg --add-architecture i386;
sudo apt-get dist-upgrade -y ;
sudo apt-get update -y;
sudo apt-get upgrade -y ;
dpkg --print-architecture;
dpkg --print-foreign-architectures;
sudo dpkg --add-architecture i386;
sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep -y --force-yes wine1.6;
sudo dpkg --add-architecture i386;
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes wine1.6;
# wine32
env WINEARCH=win32 WINEPREFIX=~/.wine winecfg;
sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep -y --force-yes q4wine;
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes q4wine;
echo "--------------------WINE1.6/8------------------------"  ;