FROM nginx

COPY ./Docker/nginx/prod/conf/nginx.conf /etc/nginx/nginx.conf
ADD ./Docker/nginx/prod/sites-enabled/ /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]
RUN usermod -u 1000 www-data
