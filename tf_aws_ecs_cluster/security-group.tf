resource "aws_security_group" "ecs" {
  name        = "tf-${var.stack_name}-ecs-sg"
  description = "ecs sg"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = 1
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.flask_port}"
    to_port     = "${var.flask_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.nginx_port}"
    to_port     = "${var.nginx_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.https_port}"
    to_port     = "${var.https_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.node_port}"
    to_port     = "${var.node_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "tf-${var.stack_name}-ecs-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}
