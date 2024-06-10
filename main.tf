terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc_for_accuknox" {
  source           = "./VPC"
  vpc_name         = var.vpc_name
  priv_subnet_name = var.priv_subnet_name
  pub_subnet_name  = var.pub_subnet_name
  priv_cidr_block  = var.priv_cidr_block
  pub_cidr_block   = var.pub_cidr_block
  ig_name          = var.ig_name
  cidr_block       = var.cidr_block
}

module "ec2_for_accuknox" {
  source          = "./EC2"
  subnet_id       = module.vpc_for_accuknox.private_vpc_id
  security_groups = module.vpc_for_accuknox.security_group_id
  ec2_name        = var.ec2_name

}

