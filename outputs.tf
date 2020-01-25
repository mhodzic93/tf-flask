output "ecs_cluster_name" {
  value = "${module.ecs_cluster.ecs_cluster_name}"
}

output "stack_name" {
  value = "${var.stack_name}"
}

output "ssl_bucket" {
  value = "${module.s3.ssl_bucket}"
}