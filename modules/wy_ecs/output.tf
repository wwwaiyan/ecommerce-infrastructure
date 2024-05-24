output "ecs_service" {
  value = aws_ecs_service.ecs_service
}
output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}
output "alb_listener_blue_arn" {
  value = module.ecs_alb.alb_listener_blue_arn
}
output "alb_listener_green_arn" {
  value = module.ecs_alb.alb_listener_green_arn
}
output "alb_tg_blue_arn" {
  value = module.ecs_alb.alb_tg_blue_arn
}
output "alb_tg_green_arn" {
  value = module.ecs_alb.alb_tg_green_arn
}
output "alb_tg_blue_name" {
  value = module.ecs_alb.alb_tg_blue_name
}
output "alb_tg_green_name" {
  value = module.ecs_alb.alb_tg_green_name
}
output "ecs_asg_arn" {
  value = module.ecs_asg.ecs_asg_arn
}
output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.ecs_task_definition.arn
}
output "alb_dns_name" {
  value = module.ecs_alb.alb_dns_name
}