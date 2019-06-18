#!/bin/bash
###redis的编译安装

###创建监听账户
useradd redis -s /sbin/nologin -M

###创建目录
mkdir -p /usr/local/redis/etc
mkdir /opt/software
##安装依赖包
yum -y install gcc gcc-c++ tcl wget

###下载安装redis包
cd /opt/software
wget http://download.redis.io/releases/redis-4.0.14.tar.gz
tar -zxvf redis-4.0.14.tar.gz
mv redis-4.0.14 redis


##编译安装
cd /opt/software/redis
make

##安装redis至/usr/local/redis目录下
make PREFIX=/usr/local/redis install


##拷贝redis的redis.conf配置文件至redis的安装目录下
cp /opt/software/redis.conf  /usr/local/redis/etc
 

##在这里修改配置/usr/local/redis/etc/redis.conf

