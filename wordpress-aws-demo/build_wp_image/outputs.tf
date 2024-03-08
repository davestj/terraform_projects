output "image_uri" {
  description = "URI of the pushed Docker image"
  value       = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.repository_name}:latest"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.wordpress-development.repository_url
}

