output "arn" {
  description = "created ecr arn"
  value       = aws_ecr_repository.ecr.arn
}
output "registry_id" {
  description = "created ecr registry id"
  value       = aws_ecr_repository.ecr.registry_id
}
output "repository_url" {
  description = "created ecr repository url"
  value       = aws_ecr_repository.ecr.repository_url
}
