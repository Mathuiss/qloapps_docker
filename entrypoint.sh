#! /bin/bash

# Create datadir for mysql
mkdir -p /var/lib/mysql
chmod -R 777 /var/lib/mysql
mysql_install_db --user=mysql --ldata=/var/lib/mysql

# Create the error log
touch /var/log/mysql/error.log
chown mysql:mysql /var/log/mysql/error.log 
chmod 640 /var/log/mysql/error.log

# Start db
service mariadb start
sync

if service mariadb status | grep -q 'MariaDB is stopped'
  then echo "MariaDB failed to start. Killing container..."
  cat /var/log/mysql/error.log
  exit 1
fi

service apache2 start
chmod -R 640 /var/lib/mysql

# Set password
mysql -u root <<-EOF
CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '';
GRANT USAGE ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL privileges ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost';

FLUSH PRIVILEGES;
SHOW GRANTS FOR '$MYSQL_USER'@localhost;
EOF

# Log the errors of the container
tail -f /var/log/apache2/*.log
