terraform {
  required_version = ">= 1.2.2"
}

provider "aws" {
      #access_key = "${var.aws_access_key}"
    #secret_key = "${var.aws_secret_key}"
    
  region = "us-east-2"

  # Allow any 2.x version of the AWS provider
  # version = "~> 2.0"
}

resource "aws_ecr_repository" "cvecr" {
  name                 = "claimvisionecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

locals {
  cluster_name = "cv-eks-cluster"
}

module "vpc" {
  source = "git::https://git@github.com/reactiveops/terraform-vpc.git?ref=v5.0.1"

  aws_region = "us-east-1"
  az_count   = 3
  aws_azs    = "us-east-1a, us-east-1b, us-east-1c"

  global_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}
  
module "eks" {
  source       = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v12.1.0"
  cluster_name = local.cluster_name
  vpc_id       = module.vpc.aws_vpc_id
  subnets      = module.vpc.aws_subnet_private_prod_ids

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 3
      min_capaicty     = 3

      instance_type = "t2.small"
    }
  }

  manage_aws_auth = false
}
