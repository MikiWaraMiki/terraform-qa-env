output "id" {
  description = "created iam role name"
  value       = aws_iam_role.role.id
}
output "arn" {
  description = "created iam role arn"
  value       = aws_iam_role.role.arn
}
output "name" {
  description = "created iam role name"
  value       = aws_iam_role.role.name
}
