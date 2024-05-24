variable "vpc_id" {}
variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
}
variable "sg_name" {
  description = "Security Group Name"
  type        = string
}
#ingress
variable "ingress_rules" {
  description = "Ingress Rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))
  default = []
}
#egress
variable "egress_rules" {
  description = "Egress Rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))
  default = []
}