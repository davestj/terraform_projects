provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "wordpress_development" {
  name = "wordpress-development"
}

