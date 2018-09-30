FROM nginx

RUN apt-get update && \
    apt-get install -y vim

COPY ./Docker/nginx/dev/conf/nginx.conf /etc/nginx/nginx.conf
ADD ./Docker/nginx/dev/sites-enabled/ /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]
RUN usermod -u 1000 www-data
