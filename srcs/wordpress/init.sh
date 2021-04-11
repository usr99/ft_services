#!/bin/sh

# -h 			database host (mysql pod)
# -u 			login with specified user
# --password	user's password
# --wait		don't abort if connection to mysql server cannot be established, retry later
# wordpress		database to use
# template.sql	SQL queries to setup wordpress database
sleep 5
mysql -h mysql-service -u wdadmin --password=wdadmin --wait wordpress < template.sql
rm -f template.sql

# Launch php-fpm and NGINX
php-fpm7 -D ; exec nginx
