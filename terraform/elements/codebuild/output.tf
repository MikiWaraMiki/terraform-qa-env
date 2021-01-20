output "id" {
  description = "created codebuild id"
  value       = aws_codebuild_project.codebuild.id
}
output "arn" {
  description = "created codebuild arn"
  value       = aws_codebuild_project.codebuild.arn
}
