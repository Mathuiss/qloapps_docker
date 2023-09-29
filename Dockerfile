FROM arm64v8/php:8.2-cli
RUN apt update && apt install -y \
    bash \
    nano \
    git

# Install QLO
RUN cd /tmp && git clone https://github.com/webkul/hotelcommerce && \
    mv hotelcommerce/* /var/www/html/ \

