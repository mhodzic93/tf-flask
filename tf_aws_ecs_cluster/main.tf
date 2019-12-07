data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars = {
    stack_name = "${var.stack_name}"
  }
}

resource "aws_launch_configuration" "ecs-lc" {
  name_prefix                 = "tf-${var.stack_name}-ecs-lc-"
  image_id                    = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.ecs.id}"]
  associate_public_ip_address = "${var.assign_public_ip}"
  user_data                   = "${data.template_file.userdata.rendered}"

  root_block_device {
    volume_type = "${var.volume_type}"
    volume_size = "${var.volume_size}"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_ecs_cluster.ecs"]
}

resource "aws_autoscaling_group" "ecs-asg" {
  name                 = "${aws_launch_configuration.ecs-lc.name}-ASG"
  vpc_zone_identifier  = ["${var.public_subnet}"]
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  force_delete         = "${var.asg_force_delete}"
  launch_configuration = "${aws_launch_configuration.ecs-lc.name}"

  tags = [
    {
      key                 = "Name"
      value               = "tf-${var.stack_name}-ecs-asg"
      propagate_at_launch = "${var.propagate_at_launch}"
    },
    {
      key                 = "Environment"
      value               = "${var.environment_type}"
      propagate_at_launch = "${var.propagate_at_launch}"
    },
    {
      key                 = "Stack"
      value               = "${var.stack_name}"
      propagate_at_launch = "${var.propagate_at_launch}"
    },
  ]

  depends_on        = ["aws_launch_configuration.ecs-lc"]
  health_check_type = "EC2"
}

resource "aws_ecs_cluster" "ecs" {
  name = "tf-${var.stack_name}-ecs"
}
