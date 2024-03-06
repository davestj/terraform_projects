provider "aws" {
  region = "us-east-1"  # Update with your desired AWS region
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]  # Update with your desired subnet IDs
}

resource "aws_security_group" "db_security_group" {
  name        = var.db_security_group_name
  description = "Allow traffic to RDS instance"
}

resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = var.db_allocated_storage
  engine               = var.db_engine
  engine_version       = var.maria_db_engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  publicly_accessible = false  # Set to true if you want the RDS instance to be publicly accessible, for secops reasons we dont want this, internal vpc only
}

output "rds_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}

output "rds_connection_details" {
  value = {
    endpoint = aws_db_instance.wordpress_db.endpoint
    username = var.db_username
    password = var.db_password
    port     = aws_db_instance.wordpress_db.port
    database = var.db_name
  }
}

