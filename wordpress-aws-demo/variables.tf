variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "us-west-2" # Update with your desired AWS region, this overrides whatever you have set in ~/.terraform.rc
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "wordpress-demo"
}

variable "aws_account_id" {
  description = "AWS account ID" #  incase of multi account.
  type        = string
  default     = ""
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
  default     = "wordpress"
}

variable "db_username" {
  description = "The username for accessing the RDS database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The password for accessing the RDS database"
  type        = string
  default     = ""
}

variable "db_instance_class" {
  description = "The instance class for the RDS database"
  type        = string
  default     = "db.t2.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage for the RDS database"
  type        = number
  default     = "20"
}

variable "db_engine" {
  description = "The engine type for the RDS database"
  type        = string
  default     = "mariadb"
}

variable "db_instance_identifier" {
  description = "The identifier for the RDS database instance"
  type        = string
  default     = "wordpress-demo"
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
  default     = "12345678"
}

variable "db_security_group_name" {
  description = "The name of the security group for the RDS database"
  type        = string
  default     = "123456789"
}

variable "aws_wp_ecr_repo_name" {
  description = "AWS ECR Repoistory Name"
  type        = string
  default     = "wordpress-development"
}
