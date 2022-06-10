resource "aws_instance" "codebuild" {
  

  provisioner "local-exec" {
    command = "terraform import -config=https://demo-meetup-awspipeline-tools-state-files.s3.us-east-2.amazonaws.com/demo-meetup-awspipeline-tools-state-files 'aws_codebuild_project.codebuild_project_terraform_plan.name ["demo_meetup_codebuild:8f1da84e-3b87-45dc-8c1e-ea9d21808c80"]'"

    
  }
}


resource "aws_codebuild_project" "codebuild_project_terraform_plan" {
  name          = var.codebuild_project_terraform_plan_name
  description   = "Terraform codebuild project"
  build_timeout = "5"
  service_role  = data.aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = var.s3_logging_bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = "true"

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "0.12.16"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.s3_logging_bucket}/${var.codebuild_project_terraform_plan_name}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yaml"
  }

  tags = {
    Terraform = "true"
  }
}