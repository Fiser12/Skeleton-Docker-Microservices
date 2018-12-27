FROM node:10.11.0-alpine AS build
ADD ./CompositeUi /app/CompositeUi

WORKDIR /app/CompositeUi

RUN npm install -g -s --no-progress yarn
RUN chmod -R 777 /app/CompositeUi
RUN npm install --no-optional
RUN yarn build

FROM fiser/symfony-microservice-dockerfile-base:php-7.2-alpine AS ecommerce
ENV APP_ENV prod

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
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
RUN echo 'date.timezone = Europe/London' >> /usr/local/etc/php/php.ini

ADD ./ECommerce /app/ECommerce

RUN php -d memory_limit=-1 /usr/local/bin/composer install -d /app/ECommerce --no-dev --no-interaction -v

RUN rm /app/ECommerce/.env /app/ECommerce/.env.dist

RUN chmod +x /app/ECommerce/etc/bash/generate_assets.sh
RUN /app/ECommerce/etc/bash/generate_assets.sh
RUN chown -R www-data:www-data /app/ECommerce
RUN chmod -R 755 /app/ECommerce

USER www-data

CMD openssl genrsa -out /app/ECommerce/var/jwt/private.pem -aes256 -passout pass:${ECOMMERCE_JWT_PASSPHRASE} 4096 && \
        openssl rsa -pubout -in /app/ECommerce/var/jwt/private.pem -out /app/ECommerce/var/jwt/public.pem -passin pass:${ECOMMERCE_JWT_PASSPHRASE} && \
        php /app/ECommerce/etc/bin/symfony-console doctrine:database:create --if-not-exists && \
        php /app/ECommerce/etc/bin/symfony-console do:mi:mi -v --no-interaction --allow-no-migration && \
        php-fpm -F


FROM nginx AS nginx
ARG env

COPY ./Docker/nginx/${env}/conf/nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/CompositeUi /app/CompositeUi
COPY --from=ecommerce /app/ECommerce /app/ECommerce

ADD ./Docker/nginx/${env}/sites-enabled/ /etc/nginx/sites-enabled/
RUN usermod -u 1000 www-data

CMD ["nginx", "-g", "daemon off;"]
