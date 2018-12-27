FROM fiser/symfony-microservice-dockerfile-base:php-7.2-alpine
ENV APP_ENV prod

# Set your timezone here
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
RUN "date"

ADD ./App /app/App

RUN php -d memory_limit=-1 /usr/local/bin/composer install -d /app/App --no-dev --no-interaction -v

RUN rm /app/App/.env /app/App/.env.dist

RUN chown -R www-data:www-data /app/App
RUN chmod -R 755 /app/App
COPY ./Docker/app/entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["php-fpm"]