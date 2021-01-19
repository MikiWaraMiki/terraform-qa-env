output "vpc_arn" {
  description = "created vpc arn"
  value       = module.network.vpc_arn
}
output "vpc_id" {
  description = "created vpc id"
  value       = module.network.vpc_id
}
output "igw_id" {
  description = "created igw id"
  value       = module.network.igw_id
}
output "igw_arn" {
  description = "created igw arn"
  value       = module.network.igw_arn
}
output "public_subnet_ids" {
  description = "created public subnet ids"
  value       = module.network.public_subnet_ids
}
output "public_subnet_arns" {
  description = "created public subnet arns"
  value       = module.network.public_subnet_arns
}
output "public_subnet_route_table_id" {
  description = "created route table id for public subnet"
  value       = module.network.public_subnet_route_table_id
}
output "private_subnet_ids" {
  description = "created private subnet ids"
  value       = module.network.private_subnet_ids
}
output "private_subnet_arns" {
  description = "created private subnet arns"
  value       = module.network.private_subnet_arns
}
output "ngw_ids" {
  description = "created natgw ids"
  value       = module.network.ngw_ids
}
