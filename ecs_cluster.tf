module "ecs_cluster" {
  source              = "tf_aws_ecs_cluster"
  ami_id              = "${var.ami_id}"
  asg_desired         = "${var.asg_desired}"
  asg_max             = "${var.asg_max}"
  asg_min             = "${var.asg_min}"
  assign_public_ip    = "${var.assign_public_ip}"
  cidr                = "${var.cidr}"
  asg_force_delete    = "${var.asg_force_delete}"
  environment_type    = "${var.environment_type}"
  flask_port          = "${var.flask_port}"
  instance_type       = "${var.instance_type}"
  key_name            = "${var.key_name}"
  propagate_at_launch = "${var.propagate_at_launch}"
  public_subnet       = "${var.public_subnet}"
  ssh_port            = "${var.ssh_port}"
  stack_name          = "${var.stack_name}"
  volume_size         = "${var.volume_size}"
  volume_type         = "${var.volume_type}"
  vpc_id              = "${var.vpc_id}"
  nginx_port          = "${var.nginx_port}"
  node_port           = "${var.node_port}"
  https_port          = "${var.https_port}"
  ssl_bucket          = "${module.s3.ssl_bucket}"
  ssl_bucket_arn      = "${module.s3.ssl_bucket_arn}"
}
