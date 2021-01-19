output "vpc_arn" {
  description = "created vpc arn"
  value       = module.vpc.arn
}
output "vpc_id" {
  description = "created vcp id"
  value       = module.vpc.id
}
output "igw_arn" {
  description = "created igw arn"
  value       = module.igw.arn
}
output "igw_id" {
  description = "created igw id"
  value       = module.igw.id
}
output "public_subnet_ids" {
  description = "created public subnet ids"
  value = [
    for subnet in module.public_subnet :
    subnet.id
  ]
}
output "public_subnet_arns" {
  description = "created public subnet ars"
  value = [
    for subnet in module.public_subnet :
    subnet.arn
  ]
}
output "public_subnet_route_table_id" {
  description = "created route table id for public subnet"
  value       = module.public_subnet_route_table.id
}
output "private_subnet_ids" {
  description = "created private subnet ids"
  value = [
    for subnet in module.private_subnet : subnet.id
  ]
}
output "private_subnet_arns" {
  description = "created private subnet arns"
  value = [
    for subnet in module.private_subnet : subnet.arn
  ]
}
output "ngw_ids" {
  description = "created natgw ids"
  value       = module.ngw_for_private_subnet.*.id
}
