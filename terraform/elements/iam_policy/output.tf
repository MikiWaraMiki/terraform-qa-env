output "id" {
  description = "created policy id"
  value       = aws_iam_policy.policy.id
}
output "arn" {
  description = "created policy arn"
  value       = aws_iam_policy.policy.arn
}
output "name" {
  description = "created policy name"
  value       = aws_iam_policy.policy.name
}
