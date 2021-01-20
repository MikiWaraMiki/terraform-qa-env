variable "pj_prefix" {
  description = "ProjectPrefix"
  type        = string
}
variable "name" {
  description = "The name of codebuild"
  type        = string
}
variable "description" {
  description = "The description of codebuild"
  type        = string
}
variable "iam_role_arn" {
  description = "Attach Codebuild Arn"
  type        = string
}
variable "build_timeout" {
  description = "build timeout setting 1 ~ 480min"
  type        = number
  default     = 5
  validation {
    condition     = var.build_timeout > 0 && var.build_timeout < 480
    error_message = "The value is 0 ~ 480."
  }
}
variable "queued_timeout" {
  description = "queued timeout setting 1 ~ 480min"
  type        = number
  default     = 5
  validation {
    condition     = var.queued_timeout > 0 && var.queued_timeout < 480
    error_message = "The value is 0 ~ 480."
  }
}
variable "source_type" {
  description = "The Codebuild Source"
  default     = "NONE"
  type        = string
}
variable "source_location" {
  description = "The location of the source code from git or s3"
  default     = null
  type        = string
}
variable "artifacts_type" {
  description = "The Codebuild Artifacts"
  default     = "NONE"
  type        = string
}
variable "env_compute_type" {
  description = " Information about the compute resources the build project will use. Available values for this parameter are: BUILD_GENERAL1_SMALL,"
  default     = "BUILD_GENERAL1_SMALL"
  type        = string
}
variable "env_image" {
  description = "The Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0"
  type        = string
  default     = "aws/codebuild/standard:2.0"
}
variable "env_type" {
  description = "The type of build environment to use for related builds. Available values are: LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER (deprecated), WINDOWS_SERVER_2019_CONTAINER or ARM_CONTAINER"
  type        = string
  default     = "LINUX_CONTAINER"
}
# codebuild内でdockerコマンドを実行しない場合はfalseに
variable "privileged_mode" {
  description = "If set to true, enables running the Docker daemon inside a Docker container. "
  type        = bool
  default     = false
}
/*
  以下のようなパラメータを想定
  {
    1: {
      name: "some_value",
      value: "fizbuz",
      type: "PLAIN_TEXT"
    }
  }
*/
variable "environment_variables" {
  description = "A set of environment variables to make available to builds for this build project"
  type        = map(map(string))
  default     = {}
}
/*
  以下のようなパラメータを想定
  事前にCloudwatchのロググループとストリームグループの作成が必要
  {
    1: {
      group_name: 'hoge',
      stream_name: 'hoge'
    }
  }
*/
variable "log_setting_params" {
  description = "codebuild log settings"
  type        = map(map(string))
  default     = {}
}
