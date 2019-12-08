#!/bin/bash

docker_name="nginx"

set -a
. ./manifest.tfvars
set +a

cd docker_images/nginx
docker build -t ${docker_name} .
docker tag flask:latest ${account_id}.dkr.ecr.${region}.amazonaws.com/${docker_name}:latest
docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${docker_name}:latest
