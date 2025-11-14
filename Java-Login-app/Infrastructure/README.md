# AWS Infrastructure for Java Application
This directory contains Terraform configurations to set up the AWS infrastructure for the Java application deployment. The infrastructure follows AWS best practices and implements a secure, scalable, and highly available architecture.
Architecture Overview
## The infrastructure consists of:

VPC with public and private subnets across multiple availability zones
Application Load Balancer (ALB) in public subnets
EC2 instances in private subnets managed by Auto Scaling Groups
RDS MySQL database in private subnets
Bastion host for secure SSH access
CloudWatch monitoring and logging
## Prerequisites
AWS Account and Credentials


AWS account with appropriate permissions
AWS CLI installed and configured
Access key and secret key with necessary permissions
## Tools

Terraform >= 1.0.0
AWS CLI >= 2.0.0
## Directory Structure

infrastructure/
├── main.tf           # Main Terraform configuration
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── modules/
│   ├── vpc/         # VPC and networking
│   ├── security/    # Security groups
│   ├── rds/         # Database
│   ├── alb/         # Load balancer
│   ├── asg/         # Auto Scaling Group
│   └── monitoring/  # CloudWatch monitoring
└── environments/    # Environment-specific configurations
    ├── dev/
    └── prod/

# Components
1.VPC
2.rds
3.alb
4.asg
5.Cloud Watch module



