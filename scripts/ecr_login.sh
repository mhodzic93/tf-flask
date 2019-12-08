#!/bin/bash

aws_profile="$1"
if [ -z "${aws_profile}" ]; then
    echo "Please specify an aws profile in argument 1 for this script"
    exit 1
fi

export AWS_ACCESS_KEY_ID=$(aws configure get ${aws_profile}.aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get ${aws_profile}.aws_secret_access_key)

set -a
. ../manifest.tfvars
set +a

login_cmd=$(aws ecr get-login --no-include-email --region ${region})

if [ "$?" -eq 0 ]; then
  echo "Retreived ecr login"
  exit 0
else
  echo "Unable to retreive ecr login"
  exit 1
fi

$login_cmd
