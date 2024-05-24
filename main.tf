module "vpc" {
  source                = "./modules/wy_vpc"
  project_name          = var.project_name
  env_prefix            = var.env_prefix
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  create_nat            = var.create_nat #required public_subnet_cidr
  public_subnet_for_nat = var.public_subnet_for_nat
  azs                   = var.azs
}

module "rds" {
  source                = "./modules/wy_rds"
  project_name          = var.project_name
  env_prefix            = var.env_prefix
  db_instance_name      = var.db_instance_name
  db_username           = var.db_username
  db_password           = var.db_password
  db_name               = var.db_name
  allocated_storage     = var.allocated_storage
  instance_class        = var.instance_class
  max_allocated_storage = var.max_allocated_storage
  engine                = var.engine
  engine_version        = var.engine_version
  vpc_id                = module.vpc.vpc[0].id
  avail_zone            = var.azs[0]
  db_subnet_1           = module.vpc.private_subnet_ids[2]
  db_subnet_2           = module.vpc.private_subnet_ids[3]
  storage_type          = var.storage_type
  sg_name               = var.rds_sg_name
  ingress_rules         = var.rds_sg_ingress_rules
  egress_rules          = var.rds_sg_egress_rules
  depends_on            = [module.vpc]
}
module "ecr" {
  source               = "./modules/wy_ecr"
  project_name         = var.project_name
  env_prefix           = var.env_prefix
  image_tag_mutability = var.ecr_image_tag_mutability
}
module "ecs" {
  source                  = "./modules/wy_ecs"
  project_name            = var.project_name
  env_prefix              = var.env_prefix
  vpc_id                  = module.vpc.vpc[0].id
  ecs_subnet_1            = module.vpc.private_subnet_ids[0]
  ecs_subnet_2            = module.vpc.private_subnet_ids[1]
  ecs_alb_public_subnet_1 = module.vpc.public_subnet_ids[0]
  ecs_alb_public_subnet_2 = module.vpc.public_subnet_ids[1]
  container_name          = var.container_name
  container_port          = var.container_port
  postgres_host           = module.rds.rds.endpoint
  postgres_user           = module.rds.rds.username
  postgres_password       = module.rds.rds.password
  postgres_db             = module.rds.rds.db_name
  postgres_port           = module.rds.rds.port
  ecs_cluster_name        = var.ecs_cluster_name
  ecs_sg_name             = var.ecs_sg_name
  ecs_sg_ingress_rules    = var.ecs_sg_ingress_rules
  ecs_sg_egress_rules     = var.ecs_sg_egress_rules
}
module "codepipeline" {
  source                           = "./modules/wy_codepipeline"
  codepipeline_bucket_name         = var.codepipeline_bucket_name
  codebuild_project_name           = var.codebuild_project_name
  codedeploy_app_name              = var.codedeploy_app_name
  codedeploy_deployment_group_name = var.codedeploy_deployment_group_name
  codepipeline_name                = var.codepipeline_name
  container_name                   = var.container_name
  container_port                   = var.container_port
  alb_listener_blue_arn            = module.ecs.alb_listener_blue_arn
  alb_listener_green_arn           = module.ecs.alb_listener_green_arn
  alb_tg_blue_name                 = module.ecs.alb_tg_blue_name
  alb_tg_green_name                = module.ecs.alb_tg_green_name
  ecs_asg_arn                      = module.ecs.ecs_asg_arn
  ecs_cluster_name                 = module.ecs.ecs_cluster_name
  ecs_service_name                 = module.ecs.ecs_service.name
  git_full_repo_id                 = var.git_full_repo_id
  git_branch_name                  = var.git_branch_name
  ecr_repository_uri               = module.ecr.ecr_repository_uri
  ecs_task_definition_arn          = module.ecs.ecs_task_definition_arn
  s3_bucket                        = module.s3.s3_bucket
}
module "s3" {
  source       = "./modules/wy_s3"
  bucket_name  = var.bucket_name
  project_name = var.project_name
  env_prefix   = var.env_prefix
}
module "cloudFront" {
  source       = "./modules/wy_cloudfront"
  alb_dns_name = module.ecs.alb_dns_name
}