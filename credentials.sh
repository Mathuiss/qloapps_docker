#!/bin/bash
set -u
##set user password
user=hoteldemo
echo -e "$USER_PASSWORD\n$USER_PASSWORD" | passwd $user
##Check for database connectivity
database_connectivity_check=no
var=1
while [ "$database_connectivity_check" != "mysql" ]; do
/etc/init.d/mysql start
database_connectivity_check=`mysqlshow --user=root | grep -o mysql`
if [ $var -ge 2 ]; then
exit 1
fi
var=$((var+1))
done
##Check for database
database_availability_check=`mysqlshow --user=root | grep -ow "$MARIADB_DATABASE"`
if [ "$database_availability_check" == "$MARIADB_DATABASE" ]; then
exit 1
else
mysqladmin -u root password $MARIADB_ROOT_PASSWORD
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "create database $MARIADB_DATABASE;"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH MARIADB_native_password BY '$MARIADB_ROOT_PASSWORD';"
# supervisorctl stop update_credentials && supervisorctl remove update_credentials
fi
