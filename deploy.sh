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

set -a
. ./${1}
set +a

export AWS_ACCESS_KEY_ID=$(aws configure get ${aws_profile}.aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get ${aws_profile}.aws_secret_access_key)

echo "Deploying terraform"
terraform apply plan.out

public_hostname=$(aws ec2 describe-instances --filters --filters "Name=tag-value,Values=$(terraform output ecs_cluster_name)" --profile ${2} | jq -r ".Reservations[].Instances[].NetworkInterfaces[].Association.PublicDnsName")
stack_name=$(terraform output stack_name)

aws s3 ls s3://$(terraform output ssl_bucket)/ssl/dhparam.pem
if [[ $? -ne 0 ]]; then
  echo "File does not exist"
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx-selfsigned.key -out nginx-selfsigned.crt -subj "/C=US/ST=Nevada/L=Las Vegas/O=${stack_name}/CN=${public_hostname}"
    openssl dhparam -out dhparam.pem 2048
    aws s3 cp nginx-selfsigned.key s3://$(terraform output ssl_bucket)/ssl/nginx-selfsigned.key
    aws s3 cp nginx-selfsigned.crt s3://$(terraform output ssl_bucket)/ssl/nginx-selfsigned.crt
    aws s3 cp dhparam.pem s3://$(terraform output ssl_bucket)/ssl/dhparam.pem
  else
    echo "File exists"
  fi
