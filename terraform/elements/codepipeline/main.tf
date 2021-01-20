resource "aws_codepipeline" "pipeline" {
  name     = var.name
  role_arn = var.role_arn

  stage {
    name = "Source"

    # Sourceがs3の場合
    dynamic "action" {
      for_each = var.is_source == "s3" ? var.source_s3_params : {}

      content {
        name             = "Source"
        category         = "Source"
        owner            = "AWS"
        provider         = "S3"
        output_artifacts = ["Source"]
        version          = "1"

        configuration = {
          S3Bucket             = action.value.s3_bucket_name
          S3ObjectKey          = action.value.s3_source_file_name
          PollForSourceChanges = true
        }
      }
    }
    # SourceがBitbucket
    dynamic "action" {
      for_each = var.is_source == "bitbucket" ? var.source_bitbucket_params : {}

      content {
        name             = "Source"
        category         = "Source"
        owner            = "AWS"
        provider         = "CodeStarSourceConnection"
        version          = "1"
        output_artifacts = ["Source"]

        configuration = {
          ConnectionArn        = action.codestar_connection_arn
          FullRepositoryId     = action.repository_id
          BranchName           = action.branch_name
          OutputArtifactFormat = "CODE_ZIP"
        }
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["Source"]
      output_artifacts = ["Build"]

      configuration = {
        ProjectName = var.codebuild_name
      }
    }
  }

  //stage {
  //  name = "Deploy"
  //
  //  action {
  //    name = "Deploy"
  //    category = "Deploy"
  //    owner = "AWS"
  //  }
  //}
  artifact_store {
    location = var.location
    type     = var.location_type
  }
}
