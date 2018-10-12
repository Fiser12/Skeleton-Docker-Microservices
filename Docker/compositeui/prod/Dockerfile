FROM node:10.11.0-alpine
ADD ./CompositeUi /app/CompositeUi

WORKDIR /app/CompositeUi

RUN npm install -g -s --no-progress yarn
RUN chmod -R 777 /app/CompositeUi
RUN npm install --no-optional
RUN yarn build

EXPOSE 8080
CMD [ "npm", "start" ]