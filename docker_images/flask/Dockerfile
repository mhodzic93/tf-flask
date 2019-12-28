FROM python:3.7-slim-stretch
EXPOSE 5000
RUN apt-get update -y

COPY ./flask_api /app
WORKDIR /app
RUN pip install -r requirements.txt

COPY ./docker_entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]