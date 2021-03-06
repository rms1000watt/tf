variable "org_name" {}
variable "aws_region" {}
variable "aws_profile" {}
variable "environment" {}
variable "aws_remote_state_region" {}

provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {}
}
