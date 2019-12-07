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

echo "Starting terraform"
terraform destroy -force -var-file="${1}"
