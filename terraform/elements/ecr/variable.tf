variable "name" {
  description = "Name of the repository"
  type        = string
}
variable "pj_prefix" {
  description = "Project Prefix"
  type        = string
}
variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  type        = bool
}
variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
  type        = string
  validation {
    condition     = var.image_tag_mutability == "MUTABLE" || var.image_tag_mutability == "IMMUTABLE"
    error_message = "Must be one of: MUTABLE or IMMUTABLE."
  }
}
