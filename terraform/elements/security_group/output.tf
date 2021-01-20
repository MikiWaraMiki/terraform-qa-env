output "id" {
  description = "created security group id"
  value       = aws_security_group.sg.id
}
output "arn" {
  description = "created security group arn"
  value       = aws_security_group.sg.arn
}
