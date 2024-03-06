variable "db_name" {
  description = "The name for the RDS database"
  type        = string
  default     = "wordpressdb"
}

variable "db_username" {
  description = "The username for accessing the RDS database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The password for accessing the RDS database"
  type        = string
}

variable "db_instance_class" {
  description = "The RDS instance class"
  type        = string
  default     = "db.t2.micro"  # Free tier instance type
}

variable "db_allocated_storage" {
  description = "The amount of storage allocated to the RDS instance (in GB)"
  type        = number
  default     = 20
}

variable "db_engine" {
  description = "The database engine to use for the RDS instance"
  type        = string
  default     = "mariadb"
}

variable "maria_db_engine_version" {
  description = "The version of the MariaDB engine"
  type        = string
  default     = "10.5"  # Update with your desired MariaDB version
}

variable "db_engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "10.5"
}

variable "db_instance_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "wordpress-db"
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
  default     = "sub-12345678"
}

variable "db_security_group_name" {
  description = "The name of the DB security group"
  type        = string
  default     = "sg-123456789"
}

