FROM php:7-apache

ARG user=hoteldemo

RUN apt-get update &&  apt-get install -y libc-client-dev git libkrb5-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libicu-dev mariadb-server
RUN docker-php-ext-install mysqli
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install imap
RUN docker-php-ext-configure gd --with-freetype --with-jpeg 
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install sockets
# RUN docker-php-ext-install intl
# RUN docker-php-ext-install opcache
RUN useradd -m -s /bin/bash ${user} \
    && mkdir -p /home/${user}/www \
##Download Qloapps latest version
    && cd /home/${user}/www && git clone https://github.com/webkul/hotelcommerce \
##change file permission and ownership
    && find /home/${user}/www -type f -exec chmod 644 {} \; \
    && find /home/${user}/www -type d -exec chmod 755 {} \; \
    && chown -R ${user}: /home/${user}/www \
    && sed -i "s@www-data@${user}@g" /etc/apache2/envvars \
    && echo ' <Directory /home/> \n\
                Options FollowSymLinks \n\  
                Require all granted  \n\
                AllowOverride all \n\
                </Directory>  ' >> /etc/apache2/apache2.conf \
    && sed -i "s@/var/www/html@/home/${user}/www/hotelcommerce@g" /etc/apache2/sites-enabled/000-default.conf

COPY ./mariadb.cnf /etc/mysql/mariadb.cnf
COPY ./entrypoint.sh /root/entrypoint.sh

ENV MYSQL_HOST=localhost \
    MYSQL_PORT=3306 \
    MYSQL_DATABASE=db_hoteldemo \
    MYSQL_USER=qlo \
    MYSQL_PASSWORD=67ajkb235Bnpasg4

ENTRYPOINT /root/entrypoint.sh