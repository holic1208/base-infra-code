resource "aws_iam_instance_profile" "instance_profile" {
  name = format("${var.name}-%s-%s", "admin_instance", "profile")
  role = aws_iam_role.admin_role.name
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "admin_role" {
  name               = format("${var.name}-%s-%s", "admin_instance", "role")
  assume_role_policy = data.aws_iam_policy_document.policy_document.json

  tags = {
    Name = format("${var.name}-%s-%s", "admin_instance", "role")
  }
}
