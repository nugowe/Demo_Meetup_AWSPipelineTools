resource "aws_ecr_repository" "demo" {
  name                 = "epltable-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
