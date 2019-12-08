# General Variables

variable "account_id" {
  description = "Sets the aws account id the infrastructure is deployed in"
}

variable "environment_type" {
  description = "Sets the environment being deployed"
}

variable "key_name" {
  description = "Sets the ec2 key pair name used on the ecs host instances"
}

variable "region" {
  description = "Sets the aws region where the infrastructure is deployed"
}

variable "stack_name" {
  description = "Sets the name of the stack"
}

variable "vpc_id" {
  description = "Sets the vpc id that the resources are using"
}

variable "public_subnet" {
  description = "Sets the public subnet that the ecs hosts are using"
}

# ECS Cluster Variables

variable "ami_id" {
  description = "Sets the ecs ami id"
  default     = "ami-0fb71e703258ab7eb"
}

variable "asg_desired" {
  description = "Sets asg desired count"
  default     = "1"
}

variable "asg_force_delete" {
  description = "Sets whether the ASG is deleted without waiting for instances to terminate"
  default     = true
}

variable "asg_max" {
  description = "Sets asg max count"
  default     = "1"
}

variable "asg_min" {
  description = "Sets asg min count"
  default     = "1"
}

variable "assign_public_ip" {
  description = "Sets whether the ecs cluster has a public ip address"
  default     = true
}

variable "cidr" {
  description = "Sets the cidr block of the VPC"
  default     = "172.31.0.0/16"
}

variable "flask_port" {
  description = "Sets the port that the flask app will run on"
  default     = 5000
}

variable "instance_type" {
  description = "Sets the instance type of the ECS cluster hosts"
  default     = "t2.micro"
}

variable "propagate_at_launch" {
  description = "Enables propagation of the tag to Amazon EC2 instances launched via this ASG"
  default     = true
}

variable "ssh_port" {
  description = "Sets the port that is used to ssh onto the ecs host"
  default     = 22
}

variable "volume_size" {
  description = "Sets the ebs volume size"
  default     = 30
}

variable "volume_type" {
  description = "Sets the ebs volume type"
  default     = "gp2"
}

# ECR Variables

variable "ecr_repos" {
  description = "List of ecr repos to build"
  default     = "flask,nginx"
}

# Flask variables
variable "conduit_secret" {
  description = "Sets the flask app secret key"
}

variable "flask_app" {
  description = "Sets the path to the autoapp.py within the container"
  default     = "/app/autoapp.py"
}

variable "flask_debug" {
  description = "Sets whether the flask app is in debug mode, 1 is yes, 0 is no"
  default     = "1"
}

# ECS service variables

variable "docker_memory" {
  description = "Sets the amount of RAM allocated to the ecs services"
  type        = "map"

  default = {
    flask = 128
    nginx = 128
  }
}

variable "docker_cpu" {
  description = "Sets the amount of CPU allocated to the ecs services"
  type        = "map"

  default = {
    flask = 128
    nginx = 128
  }
}

variable "docker_version" {
  description = "Sets the version of the image that is being deployed"
  default     = "latest"
}

variable "desired_count" {
  description = "Sets the desired number of ecs services to run"
  default     = 1
}