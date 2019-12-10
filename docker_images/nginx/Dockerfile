FROM nginx:1.16.1

EXPOSE 80

RUN apt-get update -y  && \
    apt-get install -y curl

COPY nginx.conf /etc/nginx/nginx.conf

COPY ./docker_entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]