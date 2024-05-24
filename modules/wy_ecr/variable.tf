variable "project_name" {
  description = "Django-eCommerce-Store"
  type        = string
}
variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
}
variable "image_tag_mutability" {
  description = "ecr_image_tag_mutability"
  type        = string
  default     = "IMMUTABLE"
}
