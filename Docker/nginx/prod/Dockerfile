FROM node:10.11.0-alpine AS build
ADD ./CompositeUi /app/CompositeUi

WORKDIR /app/CompositeUi

RUN npm install -g -s --no-progress yarn
RUN chmod -R 777 /app/CompositeUi
RUN npm install --no-optional
RUN yarn build

FROM nginx

COPY ./Docker/nginx/prod/conf/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/CompositeUi /app/CompositeUi

ADD ./Docker/nginx/prod/sites-enabled/ /etc/nginx/sites-enabled/
RUN usermod -u 1000 www-data

CMD ["nginx", "-g", "daemon off;"]
