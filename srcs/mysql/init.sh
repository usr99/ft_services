#!/bin/sh

# Generate init file which create wordpress database and admin user
cat << EOF > init.sql
CREATE DATABASE wordpress;
CREATE USER 'wdadmin' IDENTIFIED BY 'wdadmin';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wdadmin' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Configure MySQL
sed -i 's/skip-networking/port=3306\nbind-address=0.0.0.0\nskip-networking=false/' /etc/my.cnf.d/mariadb-server.cnf

# Create database and launch MySQL server
mysql_install_db --user=root --datadir=/var/lib/mysql
mysqld_safe --datadir=/var/lib/mysql
exec mysqld -u root --init-file=/init.sql
