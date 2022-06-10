

variable "codebuild_project_terraform_plan_name" {
  type    = string
  default = "demo_meetup_codebuild_deployment"
}

variable "codebuild_iam_role_arn" {
  type    = string
  default = "aws_iam_role.example.arn"
}

variable "s3_logging_bucket" {
  type    = string
  default = "meetupdemocodebuild"
}

variable "tf_codepipeline_name" {
  type    = string
  default = "demo_meetup_codepipeline"
}


variable "terraform_codecommit_repo_name" {
  type    = string
  default = "Meetup_DemoPresentation"
}

variable "codebuild_terraform_plan_name" {
  type    = string
  default = "demo_meetup_codebuild_deployment"
}


variable "codebuild_terraform_apply_name" {
  type    = string
  default = "code_build_apply"
}

variable "repository_branch" {
  type    = string
  default = "main"
}

variable "repository_owner" {
  type    = string
  default = "nugowe"
}

variable "repository_name" {
  type    = string
  default = "Meetup_DemoPresentation"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "cluster_name" {
  type    = string
  default = "cb-cluster"
}

variable "cluster_service" {
  type    = string
  default = "cb-service"
}

variable "codepipeline_artifact_bucket" {
  type    = string
  default = "codepipelinepractice1"
}



variable "tf_codepipeline_artifact_bucket_arn" {
  type    = string
  default = "aws_s3_bucket.tf_codepipeline_artifact_bucket.arn"
}
