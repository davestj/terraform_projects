resource "null_resource" "pull_and_push_image" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<-EOT
      docker pull wordpress:latest &&
      docker tag wordpress:latest ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.repository_name}:latest &&
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com &&
      docker push ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.repository_name}:latest
    EOT
  }
}

resource "aws_ecr_repository" "wordpress-development" {
  name = "wordpress-development"
}

