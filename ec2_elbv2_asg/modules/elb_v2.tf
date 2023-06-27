module "elb_v2" {
  source      = "./elb_v2"
  ports       = [22, 443, 80, 8080, 8000, 3000]
  target_arns = [module.ec2_instance.instance_id]
}
