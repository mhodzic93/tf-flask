#!/bin/bash
echo ECS_CLUSTER=tf-${stack_name}-ecs > /etc/ecs/ecs.config

# Install and upgrade packages
yum update -y
yum install -y python-pip
pip install --upgrade awscli

# Download ssl certs
mkdir -p /var/ssl/certs/

while true; do
    aws s3 ls s3://${ssl_bucket}/ssl/dhparam.pem
    if [[ $? -ne 0 ]]; then
      echo "Bucket is empty, waiting"
      sleep 10
    else
      echo "ssl folder exists, copying"
      aws s3 cp s3://${ssl_bucket}/ssl /var/ssl/certs/ --recursive
      break
    fi
done
