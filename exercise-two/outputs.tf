output "lb_hostname" {
  value = aws_lb.app_lb.dns_name
  description = "The direct public DNS of the load balancer."
}

output "public_facing_url" {
  value = aws_route53_record.www.name
  description = "The public facing url where this app can be accessed."
}