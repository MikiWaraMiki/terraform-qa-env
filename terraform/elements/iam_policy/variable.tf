variable "name" {
  description = "iam policy name"
  type        = string
}
variable "policy" {
  description = "iam policy document"
  type        = string
}
variable "path" {
  description = "The path of the policy in IAM."
  type        = string
  default     = "/"
}
variable "description" {
  description = "The description of the policy"
  type        = string
}
