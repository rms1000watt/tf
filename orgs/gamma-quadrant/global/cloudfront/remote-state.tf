variable "aws_profile" {}

data "terraform_remote_state" "s3" {
  backend = "s3"

  config {
    key     = "${var.environment}/s3/terraform.tfstate"
    bucket  = "${var.org_name}-global-terraform-state"
    region  = "${var.aws_remote_state_region}"
    profile = "${var.aws_profile}"
  }
}
