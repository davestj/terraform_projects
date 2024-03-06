provider "aws" {
  region = var.aws_region # Set just in case the user has no ~/.terraform.rc defined.=, else the default defined in ~/.terraform.rc is used
}

module "rds" { # Call in our aws-rds mod
  source = "./aws-rds"

  db_name                  = var.db_name
  db_username              = var.db_username
  db_password              = var.db_password
  db_instance_class        = var.db_instance_class
  db_allocated_storage     = var.db_allocated_storage
  db_engine                = var.db_engine
  db_instance_identifier   = var.db_instance_identifier
  db_subnet_group_name     = var.db_subnet_group_name
  db_security_group_name   = var.db_security_group_name
}

resource "aws_ecs_task_definition" "wordpress_task" {
  family                   = "wordpress"
  container_definitions   = file("${path.module}/wordpress_container_definitions.json")
}

resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress-service"
  cluster         = var.ecs_cluster_name
  task_definition = aws_ecs_task_definition.wordpress_task.arn
  desired_count   = 1
  launch_type     = "FARGATE" # Spendy tech

  network_configuration {
    subnets         = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]  # Update with your desired subnet IDs, or default variables
    security_groups = ["sg-123456789"]  # Update with your security group IDs, default vars could be used here....
    assign_public_ip = true # Yes, we want to be able to see wordpress, it is true.
  }
}

output "wordpress_container_dns_url" {
  value = aws_ecs_service.wordpress_service.load_balancer.first.dns_name
}

