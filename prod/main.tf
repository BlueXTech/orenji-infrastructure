terraform {
  backend "s3" {
    profile        = "orenji-infrastructure"
    region         = "ap-southeast-1"
    bucket         = "orang3-app-artifacts"
    key            = "orenji-infrastructure/prod/terraform.tfstate"
    dynamodb_table = "orang3-app-tflock-prod"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66.0"
    }
  }

  required_version = ">= 1.8.4"
}

provider "aws" {
  profile = "orenji-infrastructure"
  region  = "ap-southeast-1"
}

module "compute" {
  source = "../modules/compute"

  environment          = var.environment
  vpc_id               = var.vpc_id
  ami                  = var.ami
  instance_type        = var.instance_type
  instance_profile     = var.instance_profile
  ec2_key_name         = var.ec2_key_name
  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
  asg_azs              = var.asg_azs
  health_check_path    = var.health_check_path

  subnets                        = var.subnets
  alb_enable_deletion_protection = var.alb_enable_deletion_protection
  alb_listener_ssl_policy        = var.alb_listener_ssl_policy
  acm_certificate_arn            = var.acm_certificate_arn

  hosted_zone_id = var.hosted_zone_id
  alb_alias_url  = var.alb_alias_url
}
