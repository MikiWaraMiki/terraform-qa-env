output "public_nacl_id" {
  description = "created nacl id for public subnets"
  value       = module.nacl_for_public.id
}
output "private_nacl_id" {
  description = "created nacl id for private subnets"
  value       = module.nacl_for_private.id
}
