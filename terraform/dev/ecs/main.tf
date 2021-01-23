#
# ECS周りの設定
# ECSタスク・サービス・クラスタは、Lambdaで作成するので、
# IAMのみ設定
#
terraform {
  required_version = ">=0.13.0"
  backend "s3" {}
}

provider "aws" {
  region  = var.region
  profile = var.profile
}
data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect = "Allow"
    actions = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}
module "ecs_iam_policy" {
  source = "../../elements/iam_policy/"

  name = "ecs-task-execution-policy-${var.pj_prefix}"
  policy = data.aws_iam_policy_document.ecs_task_execution.json
  path = "/"
  description = "aws ecs task execution policy for ${var.pj_prefix}"
}
module "ecs_iam_role" {
  source = "../../elements/iam_role/"

  identifier = "ecs-tasks.amazonaws.com"
  role_name = "ecs-task-execution-role-${var.pj_prefix}"
  description = "aws ecs task execution role for ${var.pj_prefix}"
  pj_prefix = var.pj_prefix
}
module "ecs_iam_policy_attachment" {
  source = "../../elements/iam_role_policy_attachment/"

  role_name = module.ecs_iam_role.name
  policy_arn = module.ecs_iam_policy.arn
}
