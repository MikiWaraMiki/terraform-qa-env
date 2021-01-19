output "id" {
  description = "The ID of the subnet"
  value       = aws_subnet.subnet.id
}
output "arn" {
  description = "The Arn of the subnet"
  value       = aws_subnet.subnet.arn
}
