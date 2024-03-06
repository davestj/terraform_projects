# Terraform Projects

This repository contains various Terraform projects for managing infrastructure on AWS.

## Workflows

### `.github/workflows`

This directory contains GitHub Actions workflows for automating CI/CD processes.

## Terraform Modules

### `ec2_elbv1_asg`

This Terraform module checks new EC2 instances on ELB v1 with auto-scaling groups. User data scripts are included for initialization.

### `ec2_elbv2_asg`

This directory contains Terraform configuration for managing EC2 instances on ELB v2 with auto-scaling groups.

## Demo Project

### `wordpress-aws-demo`

This Terraform project deploys a WordPress application on AWS using ECS (Elastic Container Service) and RDS (Relational Database Service).

## Miscellaneous


### `Jenkinsfile`

This file contains the pipeline script for automating CI/CD build and tear-down processes in Jenkins.