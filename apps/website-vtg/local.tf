data "aws_caller_identity" "0" {}

locals {
  account_id  = "${data.aws_caller_identity.0.account_id}"
  bucket_name = "vtg-web-${local.account_id}"

  lambda_name    = "vtg-web-indexer"
  lambda_region  = "us-east-1"
  lambda_file    = "main.js"
  lambda_zip     = "${path.root}/.terraform/archive_files/${local.lambda_name}-lambda.zip"
  lambda_handler = "${basename(replace(local.lambda_file, ".js", ".handler"))}"

  role_name   = "vtg-web-indexer-${var.environment}"
  policy_name = "vtg-web-indexer-${var.environment}"
}
