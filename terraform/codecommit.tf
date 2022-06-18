resource "aws_codecommit_repository" "demo" {
  depends_on = [
    aws_ecr_repository.demo.arn
  ]
  repository_name = "epltable-repository"
  description     = "Demo Repository"
}
