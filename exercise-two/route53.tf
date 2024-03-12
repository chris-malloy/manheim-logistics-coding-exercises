data "aws_route53_zone" "root_zone" {
  name = "mynginx.org"
}

resource "aws_route53_record" "www" {
  type    = "A"
  name    = "home.mynginx.org"
  zone_id = data.aws_route53_zone.root_zone.zone_id

  alias {
    name                   = module.ecs_task.lb_hostname
    zone_id                = module.ecs_task.lb_zone_id
    evaluate_target_health = false
  }
}
