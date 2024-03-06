variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "The Big Wordpress ECS Demo with TF"
}


# Include variables from the aws-rds module, no need to redo.
module "rds_variables" {
  source = "./aws-rds"

  # Pass any necessary variables to the aws-rds module here
  # For example:
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_engine            = var.db_engine
  db_instance_identifier = var.db_instance_identifier
  db_subnet_group_name = var.db_subnet_group_name
  db_security_group_name = var.db_security_group_name
}

# Reference the variables from the aws-rds module
variable "db_name" {
  description = module.rds_variables.db_name
}

variable "db_username" {
  description = module.rds_variables.db_username
}

variable "db_password" {
  description = module.rds_variables.db_password
}

variable "db_instance_class" {
  description = module.rds_variables.db_instance_class
}

variable "db_allocated_storage" {
  description = module.rds_variables.db_allocated_storage
}

variable "db_engine" {
  description = module.rds_variables.db_engine
}

variable "db_instance_identifier" {
  description = module.rds_variables.db_instance_identifier
}

variable "db_subnet_group_name" {
  description = module.rds_variables.db_subnet_group_name
}

variable "db_security_group_name" {
  description = module.rds_variables.db_security_group_name
}

