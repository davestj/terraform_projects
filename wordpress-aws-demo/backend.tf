# Terraform Backend Configuration for S3 State Storage
terraform {
  backend "s3" {
    bucket  = "com.toolsmith-devops.ci"
    key     = "devopstoolsmiths.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

