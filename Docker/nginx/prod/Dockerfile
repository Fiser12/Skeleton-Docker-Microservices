FROM nginx

COPY ./Docker/nginx/prod/conf/nginx.conf /etc/nginx/nginx.conf
ADD ./Docker/nginx/prod/sites-enabled/ /etc/nginx/sites-enabled/
RUN usermod -u 1000 www-data
RUN mkdir /app

CMD nginx -g daemon off; cp -R /volumes/CompositeUi /app/CompositeUi
