resource "aws_iam_user" "looter1" {
  name  = var.name1
}

resource "aws_iam_access_key" "looter-key1" {
  user = aws_iam_user.looter1.name
}

resource "aws_iam_user" "looter2" {
  name  = var.name2
}

resource "aws_iam_access_key" "looter-key2" {
  user = aws_iam_user.looter2.name
}


resource "aws_iam_user" "looter3" {
  name  = var.name3
}

resource "aws_iam_access_key" "looter-key3" {
  user = aws_iam_user.looter3.name
}


resource "aws_iam_user" "looter4" {
  name  = var.name4
}

resource "aws_iam_access_key" "looter-key4" {
  user = aws_iam_user.looter4.name
}


locals {
  group_name = element(concat(aws_iam_group.looter-group1.*.id, [var.group-name1]), 0)
}

resource "aws_iam_group" "looter-group1" {
  name = var.group-name1
}

resource "aws_iam_group_membership" "looter-member1" {

  group = local.group_name
  name  = var.group-name1
  users = var.group_users1
}



resource "aws_iam_user_policy" "inline-policy1" {
  name = "looter-policy-persistance"
  user = aws_iam_user.looter2.name
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:Get*",
		"iam:List*",
		"iam:CreateAccessKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_user_policy" "inline-policy2" {
  name = "looter-policy-privilege-esc"
  user = aws_iam_user.looter3.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:Get*",
		"iam:List*",
		"iam:PutUserPolicy"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_policy" "managed-policy1" {
  name        = "looter-assumerole-policy"
  description = "Assume Role Policy for User"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:Get*",
		"iam:List*",
		"sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "managed-policy1" {
  user       = aws_iam_user.looter4.name
  policy_arn = aws_iam_policy.managed-policy1.arn
}


resource "aws_iam_group_policy_attachment" "group-managed-policy1" {
  group      = aws_iam_group.looter-group1.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}


resource "aws_iam_role" "Assume-Admin-role1" {
  name = "looter-assumerole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "${aws_iam_user.looter4.arn}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "role-managed-policy1" {
  role       = aws_iam_role.Assume-Admin-role1.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}