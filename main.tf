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

resource "aws_eks_cluster" "cveks" {
  #count = local.create ? 1 : 0

  name                      = cveksclusternp
  #role_arn                  = try(aws_iam_role.this[0].arn, var.iam_role_arn)
  #version                   = var.cluster_version
  #enabled_cluster_log_types = var.cluster_enabled_log_types

  
