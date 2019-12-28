FROM nginx:1.16.1

EXPOSE 80 443

RUN apt-get update -y  && \
    apt-get install -y curl awscli

RUN mkdir -p /etc/nginx/snippets
COPY nginx.conf /etc/nginx/nginx.conf
COPY ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY self-signed.conf /etc/nginx/snippets/self-signed.conf

COPY ./docker_entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]