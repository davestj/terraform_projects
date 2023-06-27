# variables.tf

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instance"
  type        = string
}

variable "key_pair_name" {
  description = "Key pair name for the EC2 instance"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name for artifact storage"
  type        = string
}

variable "bucket_region" {
  description = "S3 bucket region for artifact storage"
  type        = string
}

variable "bucket_encryption_keyname" {
  description = "S3 bucket encryption keyname for artifact storage"
  type        = string
}
