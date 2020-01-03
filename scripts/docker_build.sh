#!/bin/bash

variables_files="$1"
if [ -z "${variables_files}" ]; then
    echo "Please specify a variables file in argument 1 for this script"
    exit 1
fi

if [ ! -e "${variables_files}" ]; then
    echo "Could not locate variables file: ${variables_files}, specify the proper location"
    exit 1
fi

aws_profile="$2"
if [ -z "${aws_profile}" ]; then
    echo "Please specify an aws profile in argument 2 for this script"
    exit 1
fi

export AWS_ACCESS_KEY_ID=$(aws configure get ${aws_profile}.aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get ${aws_profile}.aws_secret_access_key)

set -a
. ./${1}
set +a

login_cmd=$(aws ecr get-login --no-include-email --region ${region})

if [ "$?" -eq 0 ]; then
  echo "Retreived ecr login"
  ${login_cmd}
else
  echo "Unable to retreive ecr login"
  exit 1
fi

git clone https://github.com/atahualpapena/flask_api.git docker_images/flask/flask_api
git clone https://github.com/mkhira2/express-calculator.git docker_images/node/express-calculator

for docker_name in nginx flask node
do
  docker build -t ${docker_name} docker_images/${docker_name}
  docker tag ${docker_name}:latest ${account_id}.dkr.ecr.${region}.amazonaws.com/${docker_name}:latest
  docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${docker_name}:latest
done