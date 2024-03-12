locals {
  app_port   = 80
  app_cpu    = 10
  app_memory = 256
  desired_task_count = 1

  container_definition = {
    name  = "nginx-example"
    image = "nginx:latest"

    # use all resources for now, since exactly one container definition assumed
    cpu       = local.app_cpu
    memory    = local.app_memory
    essential = true
    portMappings = [
      {
        containerPort = local.app_port
        hostPort      = 0 # tells AWS to use ephemeral port mapping
      }
    ]
  }
}
# one service on a fargate cluster for simplicity's sake
resource "aws_ecs_cluster" "main_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "main_task" {
  family                   = "${var.app_name}-tsk"
  network_mode             = "awsvpc"
  cpu                      = local.app_cpu
  memory                   = local.app_memory
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.task_role_arn
  container_definitions    = jsonencode([local.container_definition])
}

resource "aws_ecs_service" "main_service" {
  name                               = "${var.app_name}-svc"
  task_definition                    = aws_ecs_task_definition.main_task.arn
  cluster                            = aws_ecs_cluster.main_cluster.id
  desired_count                      = local.desired_task_count
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = var.service_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.service_deployment_minimum_healthy_percent
  health_check_grace_period_seconds  = var.health_check_grace_period

  load_balancer {
    container_name   = var.app_name
    container_port   = local.app_port
    target_group_arn = aws_lb_target_group.lb_targets.arn
  }

  depends_on = [aws_lb.app_lb]
}
