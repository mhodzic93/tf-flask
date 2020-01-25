resource "aws_s3_bucket" "ssl" {
  bucket        = "tf-${var.stack_name}-ssl-${var.region}"
  region        = "${var.region}"
  force_destroy = "${var.force_destroy}"
}
