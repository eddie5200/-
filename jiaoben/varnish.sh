#!/bin/bash
####varnish4.1.15的编译安装

###########安装依赖包
yum -y install autoconf automake libedit-devel libtool ncurses-devel pcre-devel pkgconfig python-docutils python-sphinx

##创建监听用户
groupadd varnish
useradd -g varnish -s /sbin/nologin varnish

####创建工作目录
mkdir /usr/local/varnish
mkdir -p /opt/software

###下载包
cd /opt/software
wget https://varnish-cache.org/_downloads/varnish-4.1.5.tgz

###解压
tar -zxvf varnish-4.1.5.tgz

###编译
cd varnish-4.1.5
./configure --prefix=/usr/local/varnish

###安装
make&&make install

#######复制配置文件
cp /opt/software/varnish-4.1.5/etc/example.vcl /usr/local/varnish/var/varnish/default.cvl
cp /opt/software/varnish-4.1.5/etc/builtin.vcl  /usr/local/varnish/var/varnish/builtin.vcl

###添加环境变量
echo "export VARNISH_HOME=/usr/local/varnish">>/etc/profile
echo "export PATH=\$VARNISH_HOME/bin:\$VARNISH_HOME/sbin:\$PATH">>/etc/profile

