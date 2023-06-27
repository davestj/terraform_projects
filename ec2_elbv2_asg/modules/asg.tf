module "asg" {
  source                 = "./asg"
  cpu_threshold          = 20
  target_group_arns      = [module.elb_v2.target_group_arn]
  associated_instances   = [module.ec2_instance.instance_id]
  min_instances          = 1
  max_instances          = 10
  desired_capacity       = 1
  health_check_grace     = 300
  vpc_zone_identifier    = [module.ec2_instance.subnet_id]
  instance_security_group= module.ec2_instance.security_group_id
}