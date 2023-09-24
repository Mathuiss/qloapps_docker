#! /bin/bash

# Run the credentials script
/etc/credentials.sh

# Run db server
service mysql start

# Start web server
service apache2 start

# Log the errors of the container
tail -f /var/log/apache2/*.log

