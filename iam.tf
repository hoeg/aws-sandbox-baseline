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

resource "aws_iam_user" "user" {
  name = "${var.username}"
}

# TODO handle secret output
resource "aws_iam_access_key" "admin-key" {
  user = "${aws_iam_user.user.name}"
}

resource "aws_iam_group_membership" "team" {
  name = "group-membership"

  users = [
    "${aws_iam_user.user.name}"
  ]

  group = "${aws_iam_group.admins.name}"
}

resource "aws_iam_account_password_policy" "simple-but-good" {
  minimum_password_length        = 12
  allow_users_to_change_password = true
}

