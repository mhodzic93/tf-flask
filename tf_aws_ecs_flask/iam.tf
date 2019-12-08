resource "aws_iam_role" "flask" {
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

resource "aws_iam_policy" "flask" {
  name        = "tf-${var.stack_name}-${var.docker_name}_policy"
  path        = "/"
  description = "tf-${var.stack_name}-${var.docker_name}_policy"
  policy      = "${data.template_file.flask-iam.rendered}"
}

data "template_file" "flask-iam" {
  template = "${file("${path.module}/iam.tpl")}"
}

resource "aws_iam_policy_attachment" "flask-attach" {
  name       = "tf-${var.stack_name}-${var.docker_name}_attach"
  roles      = ["${aws_iam_role.flask.name}"]
  policy_arn = "${aws_iam_policy.flask.arn}"
}
