FROM nginx

EXPOSE 80
#COPY nginx.conf /etc/nginx/nginx.conf

COPY ./docker_entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]