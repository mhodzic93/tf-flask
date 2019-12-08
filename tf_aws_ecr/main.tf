resource "aws_ecr_repository" "ecr" {
  count = "${length(var.ecr_repos)}"
  name  = "${element(var.ecr_repos,count.index)}"
}
