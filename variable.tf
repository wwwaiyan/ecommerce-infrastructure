#vpc
variable "project_name" {
  description = "project_name"
  type        = string
  default     = "ecommerce"
}
variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
  default     = "prod"
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.90.0.0/16"
}
#availability_zone
variable "azs" {
  description = "Availability Zone"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}
#public_subnet
variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = list(string)
  default     = ["10.90.1.0/24", "10.90.2.0/24"]
}
variable "map_public_ip_on_launch" {
  description = "Map Public IP on Launch"
  type        = bool
  default     = true
}
#private_subnet
variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = list(string)
  default     = ["10.90.3.0/24", "10.90.4.0/24", "10.90.5.0/24", "10.90.6.0/24"]
}
variable "create_nat" {
  description = "Create NAT Gateway"
  type        = bool
  default     = true
}
variable "public_subnet_for_nat" {
  description = "Public Subnet for NAT Gateway"
  type        = number
  default     = 0
}
#rds
variable "db_username" {
  description = "database username"
  type        = string
  default     = "ecouser"
}
variable "db_password" {
  description = "database password"
  type        = string
  default     = "ec0pa$$123"
}
variable "db_name" {
  description = "database name"
  type        = string
  default     = "ecodb"
}
variable "allocated_storage" {
  description = "database allocated_storage"
  type        = string
  default     = "10"
}
variable "instance_class" {
  description = "database instance class"
  type        = string
  default     = "db.t3.micro"
}
variable "max_allocated_storage" {
  description = "database max_allocated_storage"
  type        = string
  default     = "20"
}
variable "engine" {
  description = "database engine"
  type        = string
  default     = "postgres"
}
variable "engine_version" {
  description = "database engine_version"
  type        = string
  default     = "16.1"
}
variable "db_instance_name" {
  description = "database instance_name"
  type        = string
  default     = "ecommercedb"
}
variable "storage_type" {
  description = "database storage type"
  type        = string
  default     = "gp2"
}
# db_sg
variable "rds_sg_name" {
  description = "Security Group Name"
  type        = string
  default     = "db-sg"
}
#ingress
variable "rds_sg_ingress_rules" {
  description = "Ingress Rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))
  default = [
    { from_port = 5432, to_port = 5432, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "postgresql" }
  ]
}
#egress
variable "rds_sg_egress_rules" {
  description = "Egress Rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))
  default = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", description = "all allow" }
  ]
}
#ecs_sg
variable "ecs_sg_name" {
  description = "Security Group Name"
  type        = string
  default     = "ecs-sg"
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
  default = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "blue" },
    { from_port = 8080, to_port = 8080, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "green" }
  ]
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
  default = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", description = "all allow" }
  ]
}
#ecr
variable "ecr_image_tag_mutability" {
  description = "ecr_image_tag_mutability"
  type        = string
  default     = "MUTABLE"
}
#ecs
variable "ecs_cluster_name" {
  description = "ecs cluster name"
  type        = string
  default     = "ecommerce-cluster"
}
variable "container_name" {
  description = "container name"
  type        = string
  default     = "django-ecommerce-store"
}
variable "container_port" {
  description = "container port"
  default     = "80"
}
#codepipeline
variable "codepipeline_bucket_name" {
  default = "ecommerce-cp-25"
}
variable "codebuild_project_name" {
  default = "ecommerce-codebuild-project"
}
variable "codedeploy_app_name" {
  default = "ecommerce-codedeploy-app"
}
variable "codedeploy_deployment_group_name" {
  default = "ecommerce-codedeploy-deployment-group"
}
variable "codepipeline_name" {
  default = "ecommerce-codepipeline"
}
variable "git_full_repo_id" {
  default = "wwwaiyan/django-ecommerce-store"
}
variable "git_branch_name" {
  default = "master"
}
#s3
variable "bucket_name" {
  default = "ecommerce-appdata-25"
}