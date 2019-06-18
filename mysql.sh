#!/bin/bash
###安装依赖
yum -y install make gcc-c++ cmake bison-devel  ncurses-devel perl
yum install -y perl perl-devel autoconf

###添加用户组
groupadd mysql
useradd mysql -g mysql -M -s /sbin/nologin 


##下载mysql-5.6
cd /usr/local/src
wget https://downloads.mysql.com/archives/get/file/mysql-5.6.39.tar.gz
tar -zxvf mysql-5.6.39.tar.gz

##改名
mv mysql-5.6.39 mysql

##进入目录
cd mysql

##目录授权
chown -R mysql:mysql /usr/local/mysql

##编译
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/mysql/data -DSYSCONFDIR=/etc -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci

make && make install

###初始化
cd /usr/local/mysql
chmod -R 755 /usr/local/mysql
./scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql/data

###拷贝配置文件
cd /usr/local/mysql
cp /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf

##修改配置文件
echo "basedir =/usr/local/mysql 
 datadir =/usr/local/mysql/data 
 port =3306 
 socket =/tmp/mysqld.sock">>/etc/my.cnf

###设置环境变量
sed -i  's/bin/bin\:\/usr\/local\/mysql\/bin\:\/usr\/local\/mysql\/lib/g' /root/.bash_profile
source /root/.bash_profile
echo "export PATH=$PATH:/usr/local/mysql/bin">>/etc/profile
source /etc/profile
##制作成服务启动
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
chmod 755 /etc/init.d/mysql

##启动mysql
#service mysql start

cd /usr/local/mysql
./bin/mysqladmin -u root password '123'


