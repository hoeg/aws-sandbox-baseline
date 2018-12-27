resource "aws_iam_group" "admins" {
  name = "admins"
}

data "aws_iam_policy" "AdministratorAccess" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "policy-attach" {
  group      = "${aws_iam_group.admins.name}"
  policy_arn = "${aws_iam_policy.AdministratorAccess.arn}"
}
