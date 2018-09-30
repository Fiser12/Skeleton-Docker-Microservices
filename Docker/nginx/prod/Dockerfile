FROM nginx

COPY ./Docker/nginx/conf/nginx.conf /etc/nginx/nginx.conf
ADD ./Docker/nginx/sites-enabled/ /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]
RUN usermod -u 1000 www-data
