FROM fiser/symfony-microservice-dockerfile-base:php-7.2-alpine

# Set your timezone here
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
RUN "date"

CMD ["php-fpm"]