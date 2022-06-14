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

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks"
  cluster_version = "1.17"
  subnets         = ["subnet-06acb22f7edfdd754", "subnet-009974158ec3d4870"]
  vpc_id          = "vpc-0d8c98ba97abbcb29"

  node_groups = {
    public = {
      subnets          = ["subnet-06acb22f7edfdd754"]
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "t2.small"
      k8s_labels = {
        Environment = "public"
      }
    }
    private = {
      subnets          = ["subnet-009974158ec3d4870"]
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "t2.small"
      k8s_labels = {
        Environment = "private"
      }
    }
  }

}
