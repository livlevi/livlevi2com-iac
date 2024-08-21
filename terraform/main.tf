terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  cidr = var.livlev2com_vpccidr

  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Project = "livlev2.com resource"
    Created = "via Terraform"
  }
}

module "vpc" {
    source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git"

    name = "livlevi2com-vpc"
    cidr = local.cidr

    azs = local.azs
    private_subnets = var.livlevi2com_prv_subnets
    public_subnets = var.livlevi2com_pub_subnets

    enable_nat_gateway = true

    tags = local.tags

}

module "key_pair" {
    source = "git::https://github.com/terraform-aws-modules/terraform-aws-key-pair.git"

    key_name = "livlevi2com-kp"
    create_private_key = true
}

module "ec2_instance" {
    source = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name = "livlev2com-websrv"
    instance_type = "t2.micro"
    monitoring = true
    subnet_id = module.vpc.public_subnets[0]
    vpc_security_group_ids = []

    tags = local.tags
}