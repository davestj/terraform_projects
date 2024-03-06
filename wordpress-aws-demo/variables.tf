variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"  # Update with your desired AWS region, this overrides whatever you have set in ~/.terraform.rc
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "WP AWS Demo"
}

variable "aws_account_id" {
  description = "AWS account ID" #  incase of multi account.
  type        = string
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "db_username" {
  description = "The username for accessing the RDS database"
  type        = string
}

variable "db_password" {
  description = "The password for accessing the RDS database"
  type        = string
}

variable "db_instance_class" {
  description = "The instance class for the RDS database"
  type        = string
}

variable "db_allocated_storage" {
  description = "The allocated storage for the RDS database"
  type        = number
}

variable "db_engine" {
  description = "The engine type for the RDS database"
  type        = string
}

variable "db_instance_identifier" {
  description = "The identifier for the RDS database instance"
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "db_security_group_name" {
  description = "The name of the security group for the RDS database"
  type        = string
}

