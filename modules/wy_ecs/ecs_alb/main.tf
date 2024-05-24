resource "aws_lb" "ecs_alb" {
  name               = "${var.project_name}-${var.env_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ecs_alb_sg]
  subnets            = [var.public_subnet_1, var.public_subnet_2]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_tg_blue" {
  name        = "${var.project_name}-${var.env_prefix}-blue"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_target_group" "alb_tg_green" {
  name        = "${var.project_name}-${var.env_prefix}-green"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}
# resource "aws_lb_target_group_attachment" "alb-tg-attachment" {
#   target_group_arn = aws_lb_target_group.alb-tg.arn
#   target_id        = aws_lb.alb.arn
#   port             = 80
# }
resource "aws_lb_listener" "alb_listener_blue" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_blue.arn
  }
}
resource "aws_lb_listener" "alb_listener_green" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_green.arn
  }
}