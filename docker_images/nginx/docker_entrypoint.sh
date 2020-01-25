#!/bin/bash

public_hostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
sed -i "s/{{SERVER_NAME}}/$public_hostname/g" /etc/nginx/nginx.conf

macs=$(curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/)
cidr_block=$(curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$macs/vpc-ipv4-cidr-block)
resolver=$(echo $cidr_block | awk -F '.' '{print $1 "." $2 "." $3 "." "2"}')
sed -i "s/{{RESOLVER}}/$resolver/g" /etc/nginx/nginx.conf
sed -i "s/{{RESOLVER}}/$resolver/g" /etc/nginx/snippets/ssl-params.conf

nginx -g 'daemon off;'