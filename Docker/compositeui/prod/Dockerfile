FROM node:10.11-alpine

ADD ./CompositeUi /app/CompositeUi

RUN chmod -R 777 /app/CompositeUi
RUN (cd /app/CompositeUi && npm install --no-optional)
RUN (cd /app/CompositeUi && yarn build)