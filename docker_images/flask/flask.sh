#!/bin/bash

docker_name="flask"

set -a
. ./manifest.tfvars
set +a

cd docker_images/flask
git clone https://github.com/atahualpapena/flask_api.git
docker build -t ${docker_name} .
docker tag ${docker_name}:latest ${account_id}.dkr.ecr.${region}.amazonaws.com/${docker_name}:latest
docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${docker_name}:latest
