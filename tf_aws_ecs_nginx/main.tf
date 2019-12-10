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
}
