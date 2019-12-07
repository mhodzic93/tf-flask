provider "aws" {
  region      = "${var.region}"
  version     = "${var.aws_provider_version}"
  max_retries = "${var.max_retries}"
}
