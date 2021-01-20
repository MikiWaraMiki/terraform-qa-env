/*
  CodePipelineで利用する場合のS3作成
*/
resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  acl    = var.acl
  policy = var.policy

  lifecycle_rule {
    enabled = true
    expiration {
      days = var.expiration_days
    }
  }

  tags = {
    "PJPrefix" = var.pj_prefix
  }
}
