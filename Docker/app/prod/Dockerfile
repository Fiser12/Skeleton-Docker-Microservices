FROM fiser/symfony-microservice-dockerfile-base:php-7.2-alpine

# Set your timezone here
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
RUN "date"

ADD ./App /app/App

RUN chmod -R 777 /app/App

RUN composer install -d /app/App --no-dev --no-interaction

COPY ./Docker/app/prod/entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN rm /app/App/.env /app/App/.env.dist

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["php-fpm"]