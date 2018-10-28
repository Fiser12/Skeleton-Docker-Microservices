FROM fiser/symfony-microservice-dockerfile-base:php-7.2-alpine

# Set your timezone here
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
RUN "date"

# Yarn installation
RUN apk add --update nodejs nodejs-npm yarn libpng libpng-dev
RUN apk add --no-cache python make g++

# Dependencies of php
RUN docker-php-ext-install exif
RUN docker-php-ext-install gd
RUN docker-php-ext-enable exif
RUN apk del libpng-dev

ADD ./Ecommerce /app/Ecommerce

RUN chmod -R 777 /app/Ecommerce

RUN composer install -d /app/Ecommerce --no-dev --no-interaction

COPY ./Docker/app/prod/entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN /app/Ecommerce/etc/bash/generate_assets.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["php-fpm"]