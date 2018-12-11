resource "aws_iam_group_policy" "self_admin" {
  name   = "${aws_iam_group.self_admin.name}-group-policy"
  group  = "${aws_iam_group.self_admin.name}"
  policy = "${file("./policy-self-admin.json")}"
}

resource "aws_iam_group_policy" "dev_admin" {
  name   = "${aws_iam_group.dev_admin.name}-group-policy"
  group  = "${aws_iam_group.dev_admin.name}"
  policy = "${data.template_file.dev_admin.rendered}"
}
