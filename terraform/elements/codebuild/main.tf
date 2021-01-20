resource "aws_codebuild_project" "codebuild" {
  name           = var.name
  description    = var.description
  service_role   = var.iam_role_arn
  build_timeout  = var.build_timeout
  queued_timeout = var.queued_timeout

  source {
    type     = var.source_type
    location = var.source_location
  }

  artifacts {
    type = var.artifacts_type
  }

  environment {
    compute_type    = var.env_compute_type
    image           = var.env_image
    type            = var.env_type
    privileged_mode = var.privileged_mode

    dynamic "environment_variable" {
      for_each = length(var.environment_variables) > 0 ? var.environment_variables : {}

      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = environment_variable.value.type
      }
    }
  }

  dynamic "logs_config" {
    for_each = length(var.log_setting_params) > 0 ? var.log_setting_params : {}

    content {
      cloudwatch_logs {
        group_name  = logs_config.value.group_name
        stream_name = logs_config.value.stream_name
      }
    }
  }

  tags = {
    "Name"     = var.name
    "PJPrefix" = var.pj_prefix
  }
}
