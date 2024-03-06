output "wp_container_dns_url" {
  description = "The DNS URL for accessing the WordPress application."
  value       = module.ecs_service.wordpress_container_dns_url
}

output "wp_rds_endpoint" {
  description = "The endpoint of the RDS MariaDB database."
  value       = module.rds.rds_endpoint
}

output "wp_rds_connection_details" {
  description = "Connection details for accessing the RDS MariaDB database."
  value       = module.rds.rds_connection_details
}

