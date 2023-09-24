#! /bin/bash

chown -R mysql:mysql /var/lib/mysql
chmod +w /var/lub/mysql -R

# Run db server
service mysql start

if [ $? -ne 0 ]; then
    cat /var/log/mysql/error.log
    exit 1
fi

# Start web server
service apache2 start

# Run the credentials script
/etc/credentials.sh

# Log the errors of the container
tail -f /var/log/apache2/*.log
