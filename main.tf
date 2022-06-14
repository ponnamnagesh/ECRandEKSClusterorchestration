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

resource "aws_ecr_repository" "CVECR" {
  name                 = "ClaimVisionECR"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

