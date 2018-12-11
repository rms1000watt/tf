resource "aws_iam_group_membership" "self_admin" {
  name  = "${aws_iam_group.self_admin.name}_group_membership"
  group = "${aws_iam_group.self_admin.name}"

  users = [
    "${aws_iam_user.person_1.name}",
    "${aws_iam_user.person_2.name}",
  ]
}

resource "aws_iam_group_membership" "dev_admin" {
  name  = "${aws_iam_group.dev_admin.name}_group_membership"
  group = "${aws_iam_group.dev_admin.name}"

  users = [
    "${aws_iam_user.person_1.name}",
    "${aws_iam_user.person_2.name}",
  ]
}
