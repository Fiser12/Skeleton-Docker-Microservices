FROM fiser/symfony-microservice-dockerfile-base:php-7.2-alpine

# Set your timezone here
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/London /etc/localtime
RUN "date"

# Yarn installation
RUN apk add --update nodejs nodejs-npm yarn libpng libpng-dev
RUN apk add --no-cache python make g++

# Dependencies of php
RUN docker-php-ext-install gd
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif
RUN apk del libpng-dev

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN echo 'date.timezone = Europe/London' >> /usr/local/etc/php/php.ini

CMD ["php-fpm"]