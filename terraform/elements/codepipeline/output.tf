output "id" {
  description = "created pipeline id"
  value       = aws_codepipeline.pipeline.id
}
output "arn" {
  description = "created pipeline arn"
  value       = aws_codepipeline.pipeline.arn
}
