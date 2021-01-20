# config.tfvarsから読み取る
variable "region" {
  default = ""
}
variable "profile" {
  default = ""
}

variable "pj_prefix" {
  default = "sample-qa-create"
}
/*
  ../backend-config.ymlを読み込む
*/
locals {
  backend_config = yamldecode(file("../backend-config.yml"))
}

variable "codebuild_build_timeout" {
  default = 60
}
variable "codebuild_queued_timeout" {
  default = 10
}
variable "source_type" {
  default = "CODEPIPELINE"
}
variable "artifacts_type" {
  default = "CODEPIPELINE"
}
variable "env_type" {
  default = "LINUX_CONTAINER"
}
variable "env_compute_type" {
  default = "BUILD_GENERAL1_SMALL"
}
variable "env_image" {
  default = "aws/codebuild/standard:2.0"
}
variable "privileged_mode" {
  default = true
}
variable "environment_variables" {
  default = {
    1 : {
      name : "env",
      value : "prod",
      type : "PLAINTEXT"
    }
  }
}
# S3 for CODEPIPELINE
variable "bucket_name" {
  default = "tokoro-ga-dokkoi-codepipeline"
}
variable "acl" {
  default = "private"
}
variable "s3_expiration_days" {
  default = 30
}

# CodePipeline
variable "pipeline_source" {
  default = "s3"
}
variable "pipeline_source_s3_params" {
  default = {
    1 : {
      s3_bucket_name      = "tokoro-ga-dokkoi-pipeline-source"
      s3_source_file_name = "source/build.zip"
    }
  }
}
