terraform {
  required_version = ">=0.13.0"
  backend "s3" {}
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

module "codebuild_iam_role" {
  source = "../../elements/iam_role/"

  identifier  = "codebuild.amazonaws.com"
  role_name   = "codebuild-role-${var.pj_prefix}"
  description = "code build iam role. project is ${var.pj_prefix}"
  pj_prefix   = var.pj_prefix
}
data "aws_iam_policy_document" "codebuild" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DescribeRepositories",
      "ecr:DescribeImage",
      "ecr:BatchGetIamge",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
  }
}
module "codebuild_iam_policy" {
  source = "../../elements/iam_policy/"

  name        = "code-build-policy-${var.pj_prefix}"
  policy      = data.aws_iam_policy_document.codebuild.json
  path        = "/"
  description = "aws code build policy for ${var.pj_prefix}"
}
module "code_build_policy_attachment" {
  source = "../../elements/iam_role_policy_attachment/"

  role_name  = module.codebuild_iam_role.name
  policy_arn = module.codebuild_iam_policy.arn
}

module "codebuild" {
  source = "../../elements/codebuild/"

  pj_prefix             = var.pj_prefix
  name                  = "codebuild-${var.pj_prefix}"
  description           = "codebuild for ${var.pj_prefix}"
  iam_role_arn          = module.codebuild_iam_role.arn
  build_timeout         = var.codebuild_build_timeout
  queued_timeout        = var.codebuild_queued_timeout
  source_type           = var.source_type
  artifacts_type        = var.artifacts_type
  env_compute_type      = var.env_compute_type
  env_image             = var.env_image
  env_type              = var.env_type
  privileged_mode       = var.privileged_mode
  environment_variables = var.environment_variables
}


module "codepipeline_role" {
  source      = "../../elements/iam_role"
  identifier  = "codepipeline.amazonaws.com"
  role_name   = "codepipeline-role-for-${var.pj_prefix}"
  description = "iam role for codepipeline of ${var.pj_prefix}"
  pj_prefix   = var.pj_prefix
}

data "aws_iam_policy_document" "codepipeline" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTasks",
      "ecs:ListTasks",
      "ecs:RegisterTaskDefinition",
      "ecs:UpdateService",
      "iam:PassRole"
    ]
  }
}
module "codepipeline_policy" {
  source = "../../elements/iam_policy/"

  name        = "code-pipeline-policy-${var.pj_prefix}"
  policy      = data.aws_iam_policy_document.codepipeline.json
  path        = "/"
  description = "aws code pipeline policy for ${var.pj_prefix}"

}
module "codepipeline_policy_attachment" {
  source = "../../elements/iam_role_policy_attachment/"

  role_name  = module.codepipeline_role.name
  policy_arn = module.codepipeline_policy.arn
}

# CodePipelineの各ステージ(Build, Deploy)でのデータ受け渡しに利用するS3
module "s3_for_pipeline" {
  source = "../../elements/s3_of_codepipeline/"

  bucket_name     = var.bucket_name
  acl             = var.acl
  expiration_days = var.s3_expiration_days
  pj_prefix       = var.pj_prefix
}

# CodePipeline
module "codepipeline" {
  source = "../../elements/codepipeline/"

  name             = "codepipeline-${var.pj_prefix}"
  role_arn         = module.codepipeline_role.arn
  is_source        = var.pipeline_source
  source_s3_params = var.pipeline_source_s3_params
  codebuild_name   = "codebuild-${var.pj_prefix}"
  location         = module.s3_for_pipeline.id
  location_type    = "S3"
}
