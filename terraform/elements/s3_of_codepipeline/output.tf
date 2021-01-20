output "id" {
  description = "created bucket id"
  value       = aws_s3_bucket.s3.id
}
output "arn" {
  description = "created bucket arn"
  value       = aws_s3_bucket.s3.arn
}
output "bucket_domain_name" {
  description = "created bucket domain"
  value       = aws_s3_bucket.s3.bucket_domain_name
}
