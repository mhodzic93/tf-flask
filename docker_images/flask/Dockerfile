FROM python:3.6.0

EXPOSE 5000

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev libpq-dev

COPY ./flask-realworld-example-app /app
WORKDIR /app
RUN pip install -r requirements/dev.txt

COPY ./docker_entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]