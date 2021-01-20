variable "name" {
  description = "The name of codepipeline"
  type        = string
}
variable "role_arn" {
  description = "iam role id of codepipeline"
  type        = string
}
variable "is_source" {
  description = "source_type"
  type        = string
  validation {
    condition     = var.is_source == "s3" || var.is_source == "bitbucket"
    error_message = "This value must be 's3' or 'bitbucket'."
  }
}
/**
  {
    1:{
      bucket_name: 'バケット名'
      source_file_name: 'codepipelineがwatchするファイル'
    }
  }
**/
variable "source_s3_params" {
  description = "source s3 params"
  default     = null
  type        = map(map(string))
}
/**
  is_sourceがbitbucketの場合に必要なパラメータ群
  事前にcodestart connectionのarnが必要
  See. https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/connections-bitbucket.html#connections-bitbucket-cli
  {
    1:{
      codestar_connection_arn: "arn~~~",
      repository_id: "リポジトリ名(hoge/hogehoge)",
      branch_name: "codepipelineを発火するブランチ名"
    }
  }
**/
variable "source_bitbucket_params" {
  description = "source bitbucket params"
  default     = null
  type        = map(map(string))
}

variable "codebuild_name" {
  description = "codebuild name"
  type        = string
}

variable "location" {
  description = "store location path"
  type        = string
}

variable "location_type" {
  description = "location store type. default is S3"
  default     = "S3"
  type        = string
}
