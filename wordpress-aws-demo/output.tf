
output "wp_rds_endpoint" {
  description = "The endpoint of the RDS MariaDB database."
  value       = module.rds.rds_endpoint
}

output "wp_rds_connection_details" {
  description = "Connection details for accessing the RDS MariaDB database."
  value       = module.rds.rds_connection_details
}

