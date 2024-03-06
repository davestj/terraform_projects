output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.wordpress_db.endpoint
}

output "rds_connection_details" {
  description = "Connection details for accessing the RDS instance"
  value = {
    endpoint = aws_db_instance.wordpress_db.endpoint
    username = var.db_username
    password = var.db_password
    port     = aws_db_instance.wordpress_db.port
    database = var.db_name
  }
}

