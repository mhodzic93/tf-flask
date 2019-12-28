data "template_file" "ecs_task" {
  template = "${file("${path.module}/docker.json")}"

  vars = {
    CONTAINER_PORT = "${var.container_port}"
    DOCKER_CPU     = "${var.docker_cpu}"
    DOCKER_MEMORY  = "${var.docker_memory}"
    DOCKER_NAME    = "${var.docker_name}"
    DOCKER_NAME    = "${var.docker_name}"
    DOCKER_VERSION = "${var.docker_version}"
    ECR_ACCOUNT    = "${var.ecr_account}"
    ECR_REGION     = "${var.ecr_region}"
    FLASK_APP      = "${var.flask_app}"
    HOST_PORT      = "${var.host_port}"
  }
}
