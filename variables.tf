# Global Variables
variable "region" {
  description = "Sets the aws region where the infrastructure is deployed"
}

# Provider Variables
variable "aws_provider_version" {
  description = "Sets the aws provider version for Terraform"
  default     = "2.24.0"
}

variable "max_retries" {
  description = "Sets the maximum number of times an AWS api request can be made"
  default     = "50"
}
