data "aws_region" "current" {}
module "ecs_iam" {
  source                 = "./ecs_iam"
  project_name           = var.project_name
  env_prefix             = var.env_prefix
  app_data_s3_bucket_arn = var.app_data_s3_bucket_arn
}
module "ecs_asg" {
  source                    = "./ecs_asg"
  project_name              = var.project_name
  env_prefix                = var.env_prefix
  ecs_instance_profile_name = module.ecs_iam.ecs_instance_profile_name
  ecs_subnet_1              = var.ecs_subnet_1
  ecs_subnet_2              = var.ecs_subnet_2
  ecs_sg                    = module.ecs_sg.security_group_id
  ecs_cluster_name          = aws_ecs_cluster.ecs_cluster.name
  ecs_instance_type         = "c5.xlarge"
  ecsasg_desired_capacity   = 1
  ecsasg_max_size           = 7
  ecsasg_min_size           = 1
}
module "ecs_alb" {
  source          = "./ecs_alb"
  env_prefix      = var.env_prefix
  vpc_id          = var.vpc_id
  public_subnet_1 = var.ecs_alb_public_subnet_1
  public_subnet_2 = var.ecs_alb_public_subnet_2
  ecs_alb_sg      = module.ecs_sg.security_group_id
  project_name    = var.project_name
}
module "ecs_sg" {
  #this module depends on wy_vpc module
  source        = "./ecs_sg"
  sg_name       = var.ecs_sg_name
  project_name  = var.project_name
  env_prefix    = var.env_prefix
  vpc_id        = var.vpc_id
  ingress_rules = var.ecs_sg_ingress_rules
  egress_rules  = var.ecs_sg_egress_rules
}
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project_name}-${var.env_prefix}-ecs-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.ecs_cw_key.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs_cw.name
      }
    }
  }
  tags = {
    Name = "${var.project_name}-${var.env_prefix}-ecs-cluster"
  }
}

resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = "capacity_provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = module.ecs_asg.ecs_asg_arn

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 80
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 100
      instance_warmup_period    = 300
    }

    # managed_termination_protection = "ENABLED"
  }
}
resource "aws_ecs_cluster_capacity_providers" "cluster_capacity_providers" {
  cluster_name       = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
    weight            = 1
    base              = 1
  }
}

resource "aws_kms_key" "ecs_cw_key" {
  description             = "ecs_cw_key"
  deletion_window_in_days = 7
}
resource "aws_cloudwatch_log_group" "ecs_cw" {
  name = "ecs_cw"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.project_name}-${var.env_prefix}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 2

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets         = [var.ecs_subnet_1, var.ecs_subnet_2]
    security_groups = [module.ecs_sg.security_group_id]
  }
  load_balancer {
    target_group_arn = module.ecs_alb.alb_tg_blue_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

data "template_file" "container_definition" {
  template = file("${path.module}/container_definitions/definition.json.tpl")

  vars = {
    postgres_host      = var.postgres_host
    postgres_user      = var.postgres_user
    postgres_password  = var.postgres_password
    postgres_db        = var.postgres_db
    postgres_port      = var.postgres_port
    ecr_repository_uri = var.ecr_repository_uri
    app_data_s3_bucket = var.app_data_s3_bucket
    log_group_name     = aws_cloudwatch_log_group.ecs_cw.name
    aws_region         = data.aws_region.current.name
    log_stream_prefix  = "ecs-log"
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.env_prefix}-ecs-task-definition"
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = module.ecs_iam.ecs_task_execution_role_arn
  task_role_arn            = module.ecs_iam.ecs_task_execution_role_arn
  container_definitions    = data.template_file.container_definition.rendered
}