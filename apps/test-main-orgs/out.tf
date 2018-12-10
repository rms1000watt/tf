output "dev_arn" {
  value = "${aws_organizations_account.dev.arn}"
}

output "dev_id" {
  value = "${aws_organizations_account.dev.id}"
}
