data "template_file" "0" {
  template = "${file("policy.json")}"

  vars {
    region      = "${local.lambda_region}"
    account_id  = "${local.account_id}"
    lambda_name = "${local.lambda_name}"
  }
}
