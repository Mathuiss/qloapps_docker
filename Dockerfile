FROM arm64v8/php:7.4-apache
RUN apt update && apt install -y \
    bash \
    nano \
    git \
    libxml2-dev \
    libpng-dev

# Install php extentions
RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install gd
RUN docker-php-ext-install soap && docker-php-ext-enable soap
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip


# Install QLO
RUN cd /tmp && git clone https://github.com/webkul/hotelcommerce && \
    mv hotelcommerce/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html/ && \
    chmod 644 -R /var/www/html/