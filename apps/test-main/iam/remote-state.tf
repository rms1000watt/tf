data "aws_caller_identity" "0" {}

data "terraform_remote_state" "orgs" {
  backend = "s3"

  config {
    key     = "${var.environment}/orgs/terraform.tfstate"
    bucket  = "terraform-state-${var.org_name}-${data.aws_caller_identity.0.account_id}"
    region  = "${var.aws_remote_state_region}"
    profile = "${var.aws_profile}"
  }
}
