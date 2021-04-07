#!/bin/sh

sed -i 's/skip-networking/port=3306\nbind-address=0.0.0.0\nskip-networking=false/' /etc/my.cnf.d/mariadb-server.cnf

#rc-service mariadb setup && rc-service mariadb start
#mysql < tmp.sql
#rm -f tmp.sql wordpress.sql
#rc-service mariadb stop

mysql_install_db --user=root --datadir=/var/lib/mysql
mysqld_safe --datadir=/var/lib/mysql

mysqld -u root
