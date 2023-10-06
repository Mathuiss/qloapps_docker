#! /bin/bash

# Create datadir for mysql
# mkdir -p /var/lib/mysql
# chmod -R 777 /var/lib/mysql
# mysqld --initialize --user=mysql --ldata=/var/lib/mysql

# # Create the error log
# touch /var/log/mysql/error.log
# chown mysql:mysql /var/log/mysql/error.log 
# chmod 640 /var/log/mysql/error.log

# # Start db
# service mysql start
# sync

# if service mysql status | grep -q 'mysql is stopped'
#   then echo "mysql failed to start. Killing container..."
#   cat /var/log/mysql/error.log
#   exit 1
# fi

service apache2 start
# chmod -R 640 /var/lib/mysql

# Set password
# /etc/credentials.sh
# mysql -u root <<-EOF
# CREATE DATABASE $MYSQL_DATABASE;
# CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '';
# GRANT USAGE ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
# GRANT ALL privileges ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost';

# FLUSH PRIVILEGES;
# SHOW GRANTS FOR '$MYSQL_USER'@localhost;
# EOF

# Log the errors of the container

mkdir -p /var/log/apache2/
touch /var/log/apache2/access.log 
tail -f /var/log/apache2/*.log

while true
do
    echo hi
    sleep 15
done
