resource "aws_ecs_service" "nginx-service" {
  name            = "tf-${var.stack_name}-${var.docker_name}-service"
  cluster         = "${var.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.nginx-td.arn}"
  desired_count   = "${var.desired_count}"
}

resource "aws_ecs_task_definition" "nginx-td" {
  family                = "${var.stack_name}-${var.docker_name}"
  container_definitions = "${data.template_file.ecs_task.rendered}"
  task_role_arn         = "${aws_iam_role.nginx.arn}"
  network_mode          = "${var.network_mode}"

  volume {
    name      = "selfsigned_key"
    host_path = "/var/ssl/certs/nginx-selfsigned.key"
  }

  volume {
    name      = "selfsigned_crt"
    host_path = "/var/ssl/certs/nginx-selfsigned.crt"
  }

  volume {
    name      = "dhparam"
    host_path = "/var/ssl/certs/dhparam.pem"
  }
}
