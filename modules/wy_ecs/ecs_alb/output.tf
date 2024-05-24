output "alb_listener_blue_arn" {
  value = aws_lb_listener.alb_listener_blue.arn
}
output "alb_listener_green_arn" {
  value = aws_lb_listener.alb_listener_green.arn
}
output "alb_tg_blue_arn" {
  value = aws_lb_target_group.alb_tg_blue.arn
}
output "alb_tg_blue_name" {
  value = aws_lb_target_group.alb_tg_blue.name
}
output "alb_tg_green_arn" {
  value = aws_lb_target_group.alb_tg_green.arn
}
output "alb_tg_green_name" {
  value = aws_lb_target_group.alb_tg_green.name
}
output "alb_dns_name" {
  value = aws_lb.ecs_alb.dns_name
}