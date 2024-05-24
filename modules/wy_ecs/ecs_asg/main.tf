data "aws_ssm_parameter" "ecs_optimized_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}
output "ecs_optimized_ami_id" {
  value = data.aws_ssm_parameter.ecs_optimized_ami.value
}

resource "aws_launch_template" "ecs_launch_template" {
  name = "ecs-launch-template"

  image_id      = data.aws_ssm_parameter.ecs_optimized_ami.value
  instance_type = var.ecs_instance_type

  iam_instance_profile {
    name = var.ecs_instance_profile_name
  }

  vpc_security_group_ids = [var.ecs_sg]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
    EOF
  )
}

resource "aws_autoscaling_group" "ecs_asg" {
  desired_capacity = var.ecsasg_desired_capacity
  max_size         = var.ecsasg_max_size
  min_size         = var.ecsasg_min_size
  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = [var.ecs_subnet_1, var.ecs_subnet_2]

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }
}