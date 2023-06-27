# Terraform Application: AWS EC2 Instance with ELB and ASG

This Terraform application creates an AWS EC2 instance from a provided AMI ID. It also creates an ELB v2 load balancer with access to TCP ports 443, 80, 8080, 8000, and 3000 from anywhere. Additionally, it sets up an Auto Scaling Group (ASG) that launches 3 new instances when the CPU load is greater than 20%. The ASG is associated with the ELB created earlier. The application saves the details of the newly created resources (load balancer ARN, EC2 instance ID, private IP, public IP, instance DNS name, ELB DNS name, and ASG ID) to a text file and prints the results to the console. The text file is then copied to an S3 bucket for artifact storage.

## Usage

1. Install Terraform (version >= 0.12) on your machine.
2. Clone this repository and navigate to the project directory.

```shell
git clone <repository_url>
cd <project_directory>
```

3. Update the terraform.tfvars file to set your desired variable values or use command line parameters.

```hcl
ami_id                      = "ami-xxxxxxxx"
instance_size               = "t2.micro"
subnet_id                   = "subnet-xxxxxxxx"
security_group_id           = "sg-xxxxxxxx"
key_pair_name               = "my-keypair"
bucket_name                 = "my-bucket"
bucket_region               = "us-west-2"
bucket_encryption_keyname   = "my-encryption-key"
```

4. Initialize the Terraform project.

```shell
terraform init
```

5. Run the Terraform apply command to create the infrastructure.

```shell
terraform apply
```

6. After the resources are created, the output will be displayed in the console, and a text file named `output.txt` will be saved in the current directory.

7. The `output.txt` file will contain the following details:

```
Load Balancer ARN: <load_balancer_arn>
EC2 Instance ID: <ec2_instance_id>
EC2 Instance Private IP: <ec2_instance_private_ip>
EC2 Instance Public IP: <ec2_instance_public_ip>
EC2 Instance DNS Name: <ec2_instance_dns_name>
ELB DNS Name: <elb_dns_name>
Auto Scaling Group ID: <auto_scaling_group_id>
```

## Cleanup

To destroy the created resources and clean up the infrastructure, run the following command:

```shell
terraform destroy
```

Note: This will permanently delete all resources created by this Terraform configuration.

## Variables

The following variables can be set in the `terraform.tfvars` file or provided as command line arguments:

- `ami_id` (required): The ID of the AMI to use for the EC2 instance.
- `instance_size` (required): The size of the EC2 instance.
- `subnet_id` (required): The ID of the subnet to launch the EC2 instance in.
- `security_group_id` (required): The ID of the security group for the EC2 instance.
- `key_pair_name` (required): The name of the key pair to associate with the EC2 instance.
- `bucket_name` (required): The name of the S3 bucket for artifact storage.
- `bucket_region` (required): The region of the S3 bucket.
- `bucket_encryption_keyname` (required): The encryption keyname for the S3 bucket.

## Outputs

The following outputs are available after running the Terraform apply command:

- `load_balancer_arn`: The ARN of the created load balancer.


- `ec2_instance_id`: The ID of the created EC2 instance.
- `ec2_instance_private_ip`: The private IP address of the created EC2 instance.
- `ec2_instance_public_ip`: The public IP address of the created EC2 instance.
- `ec2_instance_dns_name`: The DNS name of the created EC2 instance.
- `elb_dns_name`: The DNS name of the load balancer.
- `auto_scaling_group_id`: The ID of the created Auto Scaling Group.

## Example

```hcl
ami_id                      = "ami-xxxxxxxx"
instance_size               = "t2.micro"
subnet_id                   = "subnet-xxxxxxxx"
security_group_id           = "sg-xxxxxxxx"
key_pair_name               = "my-keypair"
bucket_name                 = "my-bucket"
bucket_region               = "us-west-2"
bucket_encryption_keyname   = "my-encryption-key"
```

## Modules

This application consists of the following modules:

### EC2 Instance Module

The EC2 instance module creates a new AWS EC2 instance based on the provided AMI ID. It allows you to specify the instance size, subnet ID, security group ID, and key pair name as command line parameters or in the `variables.tf` file.

### ELB V2 Module

The ELB V2 module creates and attaches an ELB v2 load balancer to the EC2 instances. It opens TCP ports 443, 80, 8080, 8000, and 3000 to and from anywhere. The load balancer is associated with the EC2 instances created by the EC2 instance module.

### ASG Module

The ASG module sets up an ASG auto scaling group that launches new instances based on CPU load. It is associated with the ELB v2 created by the ELB V2 module. When the CPU load exceeds 20%, the auto scaling group launches three new instances.

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

module "elb_v2" {
  source      = "./elb_v2"
  ports       = [443, 80, 8080, 8000, 3000]
  target_arns = [module.ec2_instance.instance_id]
}

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
  instance_security_group= module.ec

2_instance.security_group_id
}

output "load_balancer_arn" {
  value = module.elb_v2.load_balancer_arn
}

output "ec2_instance_id" {
  value = module.ec2_instance.instance_id
}

output "ec2_instance_private_ip" {
  value = module.ec2_instance.private_ip
}

output "ec2_instance_public_ip" {
  value = module.ec2_instance.public_ip
}

output "ec2_instance_dns_name" {
  value = module.ec2_instance.dns_name
}

output "elb_dns_name" {
  value = module.elb_v2.dns_name
}

output "auto_scaling_group_id" {
  value = module.asg.auto_scaling_group_id
}
```

In this example, the application modules are used to create an EC2 instance, an ELB v2 load balancer, and an ASG auto scaling group. The output values are then printed to the console and saved to a text file named `output.txt`. The text file is copied to the specified S3 bucket for artifact storage.

This Terraform application provides a convenient way to create an AWS EC2 instance, attach an ELB v2 load balancer, and set up ASG auto scaling. It offers flexibility in configuring various parameters and allows for artifact storage in an S3 bucket. We hope this documentation helps you understand and utilize the application effectively. If you have any questions or need further assistance, please don't hesitate to reach out.

## Note

- Make sure you have appropriate permissions to create resources in the AWS account.
- Ensure that you have set up the AWS CLI with valid credentials on your machine.
- The example above uses placeholder values for the variables. Replace them with your own values before running the Terraform commands.

Feel free to modify the variables and configuration to suit your specific requirements.