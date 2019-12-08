module "ecr" {
  source = "tf_aws_ecr"
  ecr_repos = ["${split(",",var.ecr_repos)}"]
}