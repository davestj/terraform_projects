# outputs.tf

output "load_balancer_arn" {
  value = aws_lb.load_balancer.arn
}

output "instance_id" {
  value = aws_instance.ec2_instance.id
}

output "instance_private_ip" {
  value = aws_instance.ec2_instance.private_ip
}

output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "instance_dns_name" {
  value = aws_instance.ec2_instance.public_dns
}

output "load_balancer_dns_name" {
  value = aws_lb.load_balancer.dns_name
}

output "asg_id" {
  value = aws_autoscaling_group.auto_scaling_group.id
}


