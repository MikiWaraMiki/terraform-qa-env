output "ecr_arn" {
  description = "created ecr arn"
  value       = module.ecr.arn
}
output "ecr_registry_id" {
  description = "created ecr registry id"
  value       = module.ecr.registry_id
}
output "ecr_repository_url" {
  description = "created ecr repository url"
  value       = module.ecr.repository_url
}
