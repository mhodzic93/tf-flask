#!/bin/bash

docker_name="node"

set -a
. ./manifest.tfvars
set +a

cd docker_images/node
git clone https://github.com/mkhira2/express-calculator.git
docker build -t ${docker_name} .
docker tag ${docker_name}:latest ${account_id}.dkr.ecr.${region}.amazonaws.com/${docker_name}:latest
docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${docker_name}:latest
