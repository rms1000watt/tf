data "template_file" "dev_admin" {
  template = "${file("./policy-assume-role.json")}"

  vars {
    role_arn = "arn:aws:iam::${data.terraform_remote_state.orgs.dev_id}:role/OrganizationAccountAccessRole"
  }
}
