resource "aws_iam_policy" "policy" {
  name        = var.name
  policy      = var.policy
  path        = var.path
  description = var.description
}
