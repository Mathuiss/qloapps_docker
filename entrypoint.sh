#! /bin/bash


# Create datadir for mysql
mkdir /nonexistent
mkdir -p /var/lib/mysql
chmod -R 640 /var/lib/mysql
mysqld --initialize --user=mysql --ldata=/var/lib/mysql

# Create the error log
touch /var/log/mysql/error.log
chown mysql:mysql /var/log/mysql/error.log 
chmod 640 /var/log/mysql/error.log

# Start db
service mysql start
sync

if service mysql status | grep -q 'MariaDB is stopped'
  then echo "MariaDB failed to start. Killing container..."
  cat /var/log/mysql/error.log
  exit 1
fi

# Start web server
service apache2 start

# Run the credentials script
/etc/credentials.sh

# Log the errors of the container
tail -f /var/log/apache2/*.log
