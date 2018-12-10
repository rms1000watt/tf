data "template_file" "dev_admin" {
  template = "${file("./policy-assume-role.json")}"

  vars {
    role_arn = "arn:aws:iam::576536126380:role/OrganizationAccountAccessRole"
  }
}
