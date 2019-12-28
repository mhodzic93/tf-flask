#!/bin/bash

public_hostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
sed -i "s/{{SERVER_NAME}}/$public_hostname/g" /etc/nginx/nginx.conf

macs=$(curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/)
cidr_block=$(curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$macs/vpc-ipv4-cidr-block)
resolver=$(echo $cidr_block | awk -F '.' '{print $1 "." $2 "." $3 "." "2"}')
sed -i "s/{{RESOLVER}}/$resolver/g" /etc/nginx/nginx.conf
sed -i "s/{{RESOLVER}}/$resolver/g" /etc/nginx/snippets/ssl-params.conf

public_hostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=US/ST=Nevada/L=Las Vegas/O=${STACK_NAME}/CN=${public_hostname}"
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

nginx -g 'daemon off;'