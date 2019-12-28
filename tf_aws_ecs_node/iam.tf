resource "aws_iam_role" "node" {
  name = "tf-${var.stack_name}-${var.docker_name}"

  assume_role_policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":"sts:AssumeRole",
         "Principal":{
            "Service":[
               "ecs.amazonaws.com",
               "ecs-tasks.amazonaws.com"
            ]
         }
      }
   ]
}
EOF
}

resource "aws_iam_policy" "node" {
  name        = "tf-${var.stack_name}-${var.docker_name}_policy"
  path        = "/"
  description = "tf-${var.stack_name}-${var.docker_name}_policy"
  policy      = "${data.template_file.node-iam.rendered}"
}

data "template_file" "node-iam" {
  template = "${file("${path.module}/iam.tpl")}"
}

resource "aws_iam_policy_attachment" "node-attach" {
  name       = "tf-${var.stack_name}-${var.docker_name}_attach"
  roles      = ["${aws_iam_role.node.name}"]
  policy_arn = "${aws_iam_policy.node.arn}"
}
