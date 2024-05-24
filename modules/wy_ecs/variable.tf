variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
}
variable "vpc_id" {}
variable "ecs_subnet_1" {}
variable "ecs_subnet_2" {}
variable "ecs_alb_public_subnet_1" {}
variable "ecs_alb_public_subnet_2" {}
variable "container_name" {}
variable "container_port" {}
variable "ecs_cluster_name" {}
variable "postgres_host" {}
variable "postgres_user" {}
variable "postgres_password" {}
variable "postgres_db" {}
variable "postgres_port" {}
variable "ecs_sg_name" {
  description = "Security Group Name"
  type        = string
}
#ingress
variable "ecs_sg_ingress_rules" {
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
variable "ecs_sg_egress_rules" {
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