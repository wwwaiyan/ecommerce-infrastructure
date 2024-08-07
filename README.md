# ecommerce-infrastructure


I have implemented Infrastructure as Code (IAC) using Terraform to define all AWS resources, including both the AWS infrastructure and the CI/CD pipeline.

- Application source code repository:
    
    [https://github.com/wwwaiyan/django-ecommerce-store](https://github.com/wwwaiyan/django-ecommerce-store)  

#### AWS infrastructure and  CI/CD pipeline.
![](./images/aws-infrastructure.png)

```hcl
module.cloudFront.aws_cloudfront_distribution.cloudfront_distribution
module.codepipeline.data.aws_region.current
module.codepipeline.aws_codebuild_project.codebuild_project
module.codepipeline.aws_codedeploy_app.codedeploy_app
module.codepipeline.aws_codedeploy_deployment_group.codedeploy_deployment_group
module.codepipeline.aws_codepipeline.codepipeline
module.codepipeline.aws_codestarconnections_connection.codestarconnections
module.ecr.aws_ecr_repository.ecr
module.ecs.data.aws_region.current
module.ecs.data.template_file.container_definition
module.ecs.aws_cloudwatch_log_group.ecs_cw
module.ecs.aws_ecs_capacity_provider.capacity_provider
module.ecs.aws_ecs_cluster.ecs_cluster
module.ecs.aws_ecs_cluster_capacity_providers.cluster_capacity_providers
module.ecs.aws_ecs_service.ecs_service
module.ecs.aws_ecs_task_definition.ecs_task_definition
module.ecs.aws_kms_key.ecs_cw_key
module.rds.aws_db_instance.wy_rds
module.rds.aws_db_subnet_group.db_subnet_group
module.s3.aws_s3_bucket.s3_bucket
module.s3.aws_s3_bucket_cors_configuration.s3_bucket_cors
module.s3.aws_s3_bucket_policy.s3_bucket_policy
module.s3.aws_s3_bucket_public_access_block.codepipeline_bucket_pab
module.vpc.data.aws_availability_zones.available
module.vpc.aws_default_vpc.default
module.vpc.aws_eip.nat_eip[0]
module.vpc.aws_internet_gateway.igw[0]
module.vpc.aws_nat_gateway.nat_gw[0]
module.vpc.aws_route_table.private_rt[0]
module.vpc.aws_route_table.public_rt[0]
module.vpc.aws_route_table_association.private_rt_association[0]
module.vpc.aws_route_table_association.private_rt_association[1]
module.vpc.aws_route_table_association.private_rt_association[2]
module.vpc.aws_route_table_association.private_rt_association[3]
module.vpc.aws_route_table_association.public_rt_association[0]
module.vpc.aws_route_table_association.public_rt_association[1]
module.vpc.aws_subnet.private_subnet[0]
module.vpc.aws_subnet.private_subnet[1]
module.vpc.aws_subnet.private_subnet[2]
module.vpc.aws_subnet.private_subnet[3]
module.vpc.aws_subnet.public_subnet[0]
module.vpc.aws_subnet.public_subnet[1]
module.vpc.aws_vpc.vpc[0]
module.codepipeline.module.cp_iam.aws_iam_policy.codebuild_policy
module.codepipeline.module.cp_iam.aws_iam_policy.codedeploy_policy
module.codepipeline.module.cp_iam.aws_iam_policy.codepipeline_policy
module.codepipeline.module.cp_iam.aws_iam_role.codebuild_role
module.codepipeline.module.cp_iam.aws_iam_role.codedeploy_role
module.codepipeline.module.cp_iam.aws_iam_role.codepipeline_role
module.codepipeline.module.cp_iam.aws_iam_role_policy_attachment.codebuild_policy_attachment
module.codepipeline.module.cp_iam.aws_iam_role_policy_attachment.codedeploy_policy_attachment
module.codepipeline.module.cp_iam.aws_iam_role_policy_attachment.codepipeline_policy_attachment
module.codepipeline.module.cp_s3.aws_s3_bucket.codepipeline_bucket
module.codepipeline.module.cp_s3.aws_s3_bucket_public_access_block.codepipeline_bucket_pab
module.codepipeline.module.cp_s3.aws_s3_bucket_versioning.s3_bucket_versioning
module.ecs.module.ecs_alb.aws_lb.ecs_alb
module.ecs.module.ecs_alb.aws_lb_listener.alb_listener_blue
module.ecs.module.ecs_alb.aws_lb_listener.alb_listener_green
module.ecs.module.ecs_alb.aws_lb_target_group.alb_tg_blue
module.ecs.module.ecs_alb.aws_lb_target_group.alb_tg_green
module.ecs.module.ecs_asg.data.aws_ssm_parameter.ecs_optimized_ami
module.ecs.module.ecs_asg.aws_autoscaling_group.ecs_asg
module.ecs.module.ecs_asg.aws_launch_template.ecs_launch_template
module.ecs.module.ecs_iam.aws_iam_instance_profile.ecs_instance_profile
module.ecs.module.ecs_iam.aws_iam_policy.ecs_task_s3_policy
module.ecs.module.ecs_iam.aws_iam_role.ecs_instance_role
module.ecs.module.ecs_iam.aws_iam_role.ecs_task_execution_role
module.ecs.module.ecs_iam.aws_iam_role_policy_attachment.ecs_instance_role_policy
module.ecs.module.ecs_iam.aws_iam_role_policy_attachment.ecs_task_execution_role_policy
module.ecs.module.ecs_iam.aws_iam_role_policy_attachment.ecs_task_s3_policy_attachment
module.ecs.module.ecs_iam.aws_iam_role_policy_attachment.ecs_task_s3_policy_attachment_2
module.ecs.module.ecs_sg.aws_security_group.sg[0]
module.ecs.module.ecs_sg.aws_security_group_rule.egress_rules[0]
module.ecs.module.ecs_sg.aws_security_group_rule.ingress_rules[0]
module.ecs.module.ecs_sg.aws_security_group_rule.ingress_rules[1]
module.rds.module.rds_sg.aws_security_group.sg[0]
module.rds.module.rds_sg.aws_security_group_rule.egress_rules[0]
module.rds.module.rds_sg.aws_security_group_rule.ingress_rules[0]
```