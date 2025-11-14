terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}
provider "aws" {
    region = var.aws_region  
}

#VPC module
module "vpc" {
    source = "./modules/vpc"

    environment = var.environment
    vpc_cidr = var.vpc_cidr
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    azs             = var.availability_zones 
}
#Security module

module "security" {
    source = "./modules/security"

    environment = var.environment
    vpc_id = module.vpc.vpc_id
}
#RDS Module
module "RDS" {
  
}