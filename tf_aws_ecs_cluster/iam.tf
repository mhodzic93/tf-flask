resource "aws_iam_role" "ecs_cluster" {
  name = "tf-${var.stack_name}-ecs-cluster"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com",
          "ecs.amazonaws.com",
          "ecs-tasks.amazonaws.com"
      ]}
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ecs_cluster" {
  name     = "ecs-cluster-${var.stack_name}-profile"
  role     = "${aws_iam_role.ecs_cluster.name}"
}

resource "aws_iam_policy" "ecs_cluster" {
  name        = "tf-${var.stack_name}-ecs-cluster_policy"
  path        = "/"
  description = "tf-${var.stack_name}-ecs-cluser_policy"
  policy      = "${data.template_file.ecs_cluster-iam.rendered}"
}

data "template_file" "ecs_cluster-iam" {
  template = "${file("${path.module}/iam.tpl")}"

  vars {
    ssl_bucket = "${var.ssl_bucket_arn}"
  }
}

resource "aws_iam_policy_attachment" "ecs_cluster-attach" {
  name       = "tf-${var.stack_name}-ecs-cluster_attach"
  roles      = ["${aws_iam_role.ecs_cluster.name}"]
  policy_arn = "${aws_iam_policy.ecs_cluster.arn}"
}
