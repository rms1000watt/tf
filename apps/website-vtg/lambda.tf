provider "aws" {
  alias  = "0"
  region = "${local.lambda_region}"
}

data "archive_file" "0" {
  type        = "zip"
  source_file = "${local.lambda_file}"
  output_path = "${local.lambda_zip}"
}

resource "aws_lambda_function" "0" {
  filename         = "${local.lambda_zip}"
  function_name    = "${local.lambda_name}"
  handler          = "${local.lambda_handler}"
  role             = "${aws_iam_role.0.arn}"
  source_code_hash = "${data.archive_file.0.output_base64sha256}"
  runtime          = "nodejs8.10"
  timeout          = "5"
  publish          = "true"

  provider = "aws.0"
}
