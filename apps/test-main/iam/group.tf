resource "aws_iam_group" "self_admin" {
  name = "self-admin"
  path = "/"
}

resource "aws_iam_group" "dev_admin" {
  name = "dev-admin"
  path = "/"
}
