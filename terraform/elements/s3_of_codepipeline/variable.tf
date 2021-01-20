variable "bucket_name" {
  description = "bucket name"
  type        = string
}
variable "acl" {
  description = "The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private. Conflicts with grant."
  default     = "private"
  type        = string
}
variable "policy" {
  description = "A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan"
  type        = string
  default     = null
}
variable "expiration_days" {
  description = "Specifies a period in the object's expire (documented below)."
  type        = number
  default     = 30
}
variable "pj_prefix" {
  description = "ProjectPrefix"
  type        = string
}
