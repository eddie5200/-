#!/bin/bash
##zabbix的编译安装

##在mysql中创建用户
##创建zabbix数据库，创建zabbix账号
mysql -u root -p -e "create database zabbix character set utf8 collate utf8_bin;"
mysql -u root -p -e "grant all privileges on zabbix.* to 'zabbix'@'localhost' identified by 'zabbix';"
mysql -u root -p -e " flush privileges;"

##创建相关用户
useradd zabbix -s /sbin/nologin

##创建相关目录
mkdir /usr/local/zabbix
mkdir /usr/local/log/zabbix

##授权
chown -R zabbix:zabbix /usr/local/log/zabbix

##下载zabbix包
cd /opt/sofware
wget https://sourceforge.net/projects/zabbix/files/ZABBIX%20Latest%20Stable/3.0.28/zabbix-3.0.28.tar.gz/download
tar -zxvf zabbix-3.0.28.tar.gz -C /usr/local/zabbix
mv zabbix-3.0.28.tar.gz zabbix

##编译安装
cd zabbix
./configure --prefix=/opt/service/zabbix --enable-server --enable-agent --with-mysql=/usr/local/mysql/bin/mysql_config --with-net-snmp --with-libcurl --with-libxml2

make&&make install



