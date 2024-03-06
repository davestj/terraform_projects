# WordPress AWS Demo Terraform Module

This Terraform module deploys a WordPress application on AWS using ECS (Elastic Container Service) and RDS (Relational Database Service).

## Features

- Deploys WordPress on ECS with Fargate launch type
- Sets up RDS MariaDB database for WordPress backend
- Uses AWS Load Balancer for routing traffic to ECS containers
- Configures security groups, subnets and IAM Roles if not already done.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/wordpress-aws-demo.git
    ```

2. Navigate to the `wordpress-aws-demo` directory:

    ```bash
    cd wordpress-aws-demo
    ```

3. Set up AWS credentials and region settings in your `~/.terraform.rc` file. Edit or create the file if it doesn't exist:

    ```ini
    credentials "default" {
      aws_access_key_id = "your-access-key-id"
      aws_secret_access_key = "your-secret-access-key"
    }

    provider "aws" {
      region = "us-west-2"  # Update with your desired AWS region
    }
    ```

   Replace `"your-access-key-id"` and `"your-secret-access-key"` with your actual AWS credentials. Also, update the region value as needed.

   **Note:** Avoid including sensitive information like AWS credentials directly in the Terraform configuration files. Using the `~/.terraform.rc` file provides a more secure way to manage credentials.

4. Initialize Terraform:

    ```bash
    terraform init
    ```

5. Review and adjust the `variables.tf` file according to your requirements.

6. Plan the infrastructure changes:

    ```bash
    terraform plan
    ```

   Review the plan output to ensure it matches your expectations before applying changes.

7. Deploy the infrastructure:

    ```bash
    terraform apply
    ```

8. After deployment, the output will provide the DNS URL for accessing the WordPress application.

9. To destroy the infrastructure, run:

    ```bash
    terraform destroy
    ```

## Variables

- `aws_region`: The AWS region where the infrastructure will be deployed.
- `ecs_cluster_name`: The name of the ECS cluster.
- `aws_account_id`: AWS account ID.
- Other variables for configuring RDS, ECS, and networking parameters.

## Outputs

- `wordpress_container_dns_url`: The DNS URL for accessing the WordPress application.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
