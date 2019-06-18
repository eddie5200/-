#!/bin/bash
##php的编译安装

##创建目录
mkdir /usr/local/php
mkdir -p  /usr/local/log/php
mkdir -p  /usr/local/php/etc/php-fpm.d
#chown -R 777 /usr/local/log/php

###创建监听用户

groupadd www
useradd -s /sbin/nologin -g www www
##安装epel源
yum -y install epel-release
yum -y install php-fpm php-mysql
yum -y install gcc  openssl 
##安装依赖包
yum -y install libmcrypt-devel mcrypt mhash gd-devel ncurses-devel libxml2-devel bzip2-devel libcurl-devel curl-devel libjpeg-devel libpng-devel freetype-devel net-snmp-devel openssl-devel libmcrypt-devel

###下载php包
mkdir /opt/software
cd /opt/software
##wget https://www.php.net/distributions/php-5.6.18.tar.gz
tar -zxvf php-5.6.18.tar.gz

###改名
mv php-5.6.18 php

##编译
cd php
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=php-fpm --with-fpm-group=php-fpm --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-pdo-mysql=/usr/local/mysql --with-mysql-sock=/tmp/mysql.sock --with-libxml-dir --with-gd --with-jpeg-dir --with-png-dir --with-freetype-dir --with-iconv-dir --with-zlib-dir --with-mcrypt --enable-soap --enable-gd-native-ttf --enable-ftp --enable-mbstring --enable-exif --with-pear --with-curl  --with-openssl

make&&make install

###复制配置文件
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /opt/software/php/php.ini-production /usr/local/php/etc/php.init
cp /etc/php-fpm.d/.www.conf  /usr/local/php/etc/php-fpm.d/.www.conf

####复制systemctl服务启动的配置文件
cp /opt/software/php/sapi/fpm/php-fpm.service /usr/lib/systemd/system/php-fpm.service

###复制启动脚本配置文件
cp /opt/software/php/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod -R 755 /etc/init.d/php-fpm


