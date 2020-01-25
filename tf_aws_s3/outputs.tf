output "ssl_bucket" {
  value = "${aws_s3_bucket.ssl.bucket}"
}

output "ssl_bucket_arn" {
  value = "${aws_s3_bucket.ssl.arn}"
}
