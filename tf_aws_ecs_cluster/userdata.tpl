#!/bin/bash
echo ECS_CLUSTER=tf-${stack_name}-ecs > /etc/ecs/ecs.config

yum update -y
