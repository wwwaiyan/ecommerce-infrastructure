variable "project_name" {
  description = "project_name"
  type        = string
}
variable "db_username" {
  description = "database username"
  type        = string
}
variable "db_password" {
  description = "database password"
  type        = string
}
variable "db_name" {
  description = "database name"
  type        = string
}
variable "allocated_storage" {
  description = "database allocated_storage"
  type        = string
}
variable "instance_class" {
  description = "database instance class"
  type        = string
}
variable "max_allocated_storage" {
  description = "database max_allocated_storage"
  type        = string
}
variable "engine" {
  description = "database engine"
  type        = string
}
variable "engine_version" {
  description = "database engine_version"
  type        = string
}
variable "db_instance_name" {
  description = "database instance_name"
  type        = string
}
variable "env_prefix" {
  description = "env_prefix"
  type        = string
}
variable "vpc_id" {
  description = "database vpc_id"
  type        = string
}
variable "avail_zone" {
  description = "database avail_zones"
  type        = string
}
variable "db_subnet_1" {
  description = "database subnet 1"
  type        = string
}
variable "db_subnet_2" {
  description = "database subnet 2"
  type        = string
}
variable "storage_type" {
  description = "database storage type"
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