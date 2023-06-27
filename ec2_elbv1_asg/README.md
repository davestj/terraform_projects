# Terraform Application

This Terraform application allows you to create an AWS EC2 instance and attach an ELB v1 load balancer. It also sets up an ASG auto scaling group that launches new instances based on CPU load. The application saves relevant information to a text file and prints the results to the console. Additionally, it provides options for configuring instance size, subnet ID, security group ID, key pair name, and artifact storage in an S3 bucket.

## Usage

To use this application, follow the steps below:

1. Install Terraform (version 0.12.0 or later) on your local machine.
2. Clone the repository containing this application.
3. Navigate to the application directory.
4. Update the `variables.tf` file to set your desired variable values or use command line parameters.
5. Initialize the Terraform working directory by running the command `terraform init`.
6. Review the plan to ensure it matches your expectations by running the command `terraform plan`.
7. Apply the changes by running the command `terraform apply`.
8. After the apply is complete, the output will display the load balancer ARN, EC2 instance ID, private IP, public IP, instance DNS name, ELB DNS name, and ASG ID. These values will also be saved to a text file named `output.txt` in the local directory.
9. The text file will be copied to the specified S3 bucket for artifact storage.

## Modules

This application consists of the following modules:

### EC2 Instance Module

The EC2 instance module creates a new AWS EC2 instance based on the provided AMI ID. It allows you to specify the instance size, subnet ID, security group ID, and key pair name as command line parameters or in the `variables.tf` file.

### ELB V1 Module

The ELB V1 module creates and attaches an ELB v1 load balancer to the EC2 instances. It opens TCP ports 22, 443, 80, 8080, 8000, and 3000 to and from anywhere. The load balancer is associated with the EC2 instances created by the EC2 instance module.

### ASG Module

The ASG module sets up an ASG auto scaling group that launches new instances based on CPU load. It is associated with the ELB v1 created by the ELB V1 module. When the CPU load exceeds 20%, the auto scaling group launches three new instances.

## Example

To demonstrate the usage of this application, consider the following example:

```hcl
module "ec2_instance" {
  source            = "./ec2_instance"
  ami_id            = "ami-0123456789"
  instance_type     = "t2.micro"
  subnet_id         = "subnet-0123456789"
  security_group_id = "sg-0123456789"
  key_pair_name     = "my-keypair"
}

module "elb_v1" {
  source      = "./elb_v1"
  ports       = [22, 443, 80, 8080, 8000, 3000]
  target_arns = [module.ec2_instance.instance_id]
}

module "asg" {
  source              = "./asg"
  cpu_threshold       = 20
  target_group_arns   = [module.elb_v1.target_group_arn]
  associated_instances = [module.ec2_instance.instance_id]
  min_instances       = 1
  max_instances       = 10
  desired_capacity    = 1
  health_check_grace  = 300
}
```


# Terraform command line ops Example


```hcl
terraform apply \
  -var 'ami_id=ami-0123456789' \
  -var 'instance_size=t2.micro' \
  -var 'subnet_id=subnet-0123456789' \
  -var 'security_group_id=sg-0123456789' \
  -var 'key_pair_name=my-keypair' \
  -var 'bucket_name=my-bucket' \
  -var 'bucket_region=us-west-2' \
  -var 'bucket_encryption_keyname=my-keyname'
```

In this example, the application is invoked with command line parameters to specify the AMI ID, instance size, subnet ID, security group ID, key pair name, S3 bucket name, bucket region, and bucket encryption key name.

## Conclusion

This Terraform application provides an easy way to create an AWS EC2 instance, attach an ELB v1 load balancer, and set up ASG auto scaling. It offers flexibility in configuring instance properties and allows for artifact storage in an S3 bucket. We hope this documentation helps you understand and utilize the application effectively. If you have any questions or need further assistance, please don't hesitate to reach out.