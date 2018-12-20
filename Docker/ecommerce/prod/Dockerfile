FROM fiser/symfony-microservice-dockerfile-base:php-7.2-alpine
ENV APP_ENV prod

# Set your timezone here
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
RUN "date"

# Yarn installation
RUN apk add --update nodejs nodejs-npm yarn libpng libpng-dev
RUN apk add --no-cache python make g++

# Dependencies of php
RUN docker-php-ext-install gd
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif
RUN apk del libpng-dev

ADD ./ECommerce /app/ECommerce

RUN chmod -R 777 /app/ECommerce

RUN php -d memory_limit=-1 /usr/local/bin/composer install -d /app/ECommerce --no-dev --no-interaction -v

COPY ./Docker/ecommerce/prod/entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN rm /app/ECommerce/.env /app/ECommerce/.env.dist

RUN /app/ECommerce/etc/bash/generate_assets.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["php-fpm"]