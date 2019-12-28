FROM node:jessie
EXPOSE 3000
RUN apt-get update -y

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY ./express-calculator /usr/src/app
RUN npm install

COPY ./docker_entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]