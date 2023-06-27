# main.tf


resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_pair_name
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "EC2 Instance"
  }
}

resource "aws_lb" "load_balancer" {
  name               = "ELB"
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.security_group_id]
  subnets         = [var.subnet_id]

  enable_deletion_protection = true

  tags = {
    Name = "ELB"
  }

  listener {
    port     = 443
    protocol = "HTTPS"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
  }

  listener {
    port     = 80
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
  }

  listener {
    port     = 8080
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
  }

  listener {
    port     = 8000
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
  }

  listener {
    port     = 3000
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.ec2_instance.id
  port             = 80
}



resource "aws_autoscaling_group" "auto_scaling_group" {
  name                      = "ASG"
  min_size                  = 1
  max_size                  = 5
  desired_capacity          = 2
  health_check_type         = "EC2"
  default_cooldown          = 300
  vpc_zone_identifier       = [var.subnet_id]
  target_group_arns         = [aws_lb_target_group.target_group.arn]
  termination_policies      = ["Default"]
  wait_for_capacity_timeout = "10m"

  tag {
    key                 = "Name"
    value               = "ASG"
    propagate_at_launch = true
  }

  metric {
    type  = "CPUUtilization"
    unit  = "Percent"
    value = 20
  }
}

resource "null_resource" "output_to_file" {
  provisioner "local-exec" {
    command = <<EOF
echo "Load Balancer ARN: ${aws_lb.load_balancer.arn}"
echo "EC2 Instance ID: ${aws_instance.ec2_instance.id}"
echo "EC2 Instance Private IP: ${aws_instance.ec2_instance.private_ip}"
echo "EC2 Instance Public IP: ${aws_instance.ec2_instance.public_ip}"
echo "EC2 Instance DNS Name: ${aws_instance.ec2_instance.public_dns}"
echo "Load Balancer DNS Name: ${aws_lb.load_balancer.dns_name}"
echo "Auto Scaling Group ID: ${aws_autoscaling_group.auto_scaling_group.id}"
EOF
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "aws_s3_bucket_object" "artifact" {
  bucket = var.bucket_name
  key    = "output.txt"
  source = "${path.module}/output.txt"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.bucket_name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/*"
    }
  ]
}
EOF
}

