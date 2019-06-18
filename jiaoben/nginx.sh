#!/bin/bash
##关闭防火墙
getenforce
systemctl stop firewalld

###安装依赖
yum -y install gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl-devel

##下载nginx包
mkdir /opt/software
cd /opt/software
wget -c https://nginx.org/download/nginx-1.6.2.tar.gz

##解压
tar -zxvf nginx-1.6.2.tar.gz 
cd nginx-1.6.2

###编译
./configure --prefix=/usr/local/nginx 
--conf-path=/usr/local/nginx/conf/nginx.conf 
--pid-path=/usr/local/nginx/conf/nginx.pid 
--lock-path=/var/lock/nginx.lock 
--error-log-path=/var/log/nginx/error.log 
--http-log-path=/var/log/nginx/access.log 
--with-http_gzip_static_module 
--http-client-body-temp-path=/var/temp/nginx/client
--http-proxy-temp-path=/var/temp/nginx/proxy 
--http-fastcgi-temp-path=/var/temp/nginx/fastcgi 
--http-uwsgi-temp-path=/var/temp/nginx/uwsgi 
--http-scgi-temp-path=/var/temp/nginx/scgi

make&make install

##修改监听端

listen 8090;
