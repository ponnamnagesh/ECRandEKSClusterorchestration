resource "aws_ecr_repository" "cvecr" {
  name                 = "ClaimVisionECR"
  name                 = "claimvisionecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
