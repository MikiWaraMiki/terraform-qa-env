output "id" {
  description = "created eip id"
  value       = aws_eip.eip.id
}
output "public_ip" {
  description = "created eip public ip address"
  value       = aws_eip.eip.public_ip
}
