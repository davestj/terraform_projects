# ec2_elb_asg.tf

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

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_group_ids = [var.security_group_id]
  key_name      = var.key_pair_name
}

resource "aws_elb" "load_balancer" {
  name               = "my-load-balancer"
  security_groups    = [var.security_group_id]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 8080
    instance_protocol = "tcp"
    lb_port           = 8080
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 8000
    instance_protocol = "tcp"
    lb_port           = 8000
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 3000
    instance_protocol = "tcp"
    lb_port           = 3000
    lb_protocol       = "tcp"
  }

  health_check {
    target              = "TCP:80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }

  instances = [aws_instance.ec2_instance.id]
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  name                 = "my-auto-scaling-group"
  min_size             = 1
  max_size             = 10
  desired_capacity     = 1
  vpc_zone_identifier  = [var.subnet_id]
  launch_configuration = aws_launch_configuration.launch_configuration.name
}

resource "aws_launch_configuration" "launch_configuration" {
  name                 = "my-launch-configuration"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = [var.security_group_id]
  key_name             = var.key_pair_name
  user_data            = file("user_data.sh")
}

data "template_file" "user_data" {
  template = file("user_data.tpl")
}

output "load_balancer_arn" {
  value = aws_elb.load_balancer.arn
}

output "ec2_instance_id" {
  value = aws_instance.ec2_instance.id
}

output "ec2_instance_private_ip" {
  value = aws_instance.ec2_instance.private_ip
}

output "ec2_instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "ec2_instance_dns_name" {
  value = aws_instance.ec2_instance.public_dns
}

output "elb_dns_name" {
  value = aws_elb.load_balancer.dns_name
}

output "auto_scaling_group_id" {
  value = aws_autoscaling_group.auto_scaling_group.id
}

locals {
  artifact_file_content = <<EOT
Load Balancer ARN: ${aws_elb.load_balancer.arn}
EC2 Instance ID: ${aws_instance.ec2_instance.id}
EC2 Instance Private IP: ${aws_instance.ec2_instance.private_ip}
EC2 Instance Public IP: ${aws_instance.ec2_instance.public_ip}
EC2 Instance DNS Name: ${aws_instance.ec2_instance.public_dns}
ELB DNS Name: ${aws_elb.load_balancer.dns_name}
ASG ID: ${aws_autoscaling_group.auto_scaling_group.id}
EOT
}

resource "local_file" "artifact_file" {
  content     = local.artifact_file_content
  filename    = "output.txt"
  description = "Output artifact file"
}

resource "aws_s3_bucket_object" "artifact_object" {
  bucket       = var.bucket_name
  key          = "output.txt"
  source       = local_file.artifact_file.filename
  content_type = "text/plain"
}

output "artifact_s3_object_url" {
  value = aws_s3_bucket_object.artifact_object.id
}
