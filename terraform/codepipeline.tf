
resource "aws_codepipeline" "tf_codepipeline" {
  depends_on = [
    aws_ecr_repository.demo.arn
  ]
  name     = var.tf_codepipeline_name
  role_arn = data.aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.codepipeline_artifact_bucket
    type     = "S3"
  }




  
  
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        RepositoryName = var.terraform_codecommit_repo_name
        BranchName     = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      category = "Build"
      configuration = {
        "EnvironmentVariables" = jsonencode(
          [
            {
              name  = "environment"
              type  = "PLAINTEXT"
              value = var.env
            },
          ]
        )
        "ProjectName" = "demo_meetup_codebuild"
      }
      input_artifacts = [
        "SourceArtifact",
      ]
      name = "Build"
      output_artifacts = [
        "BuildArtifact",
      ]
      owner     = "AWS"
      provider  = "CodeBuild"
      run_order = 2
      version   = "1"
    }
  }



  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        "ClusterName" = var.cluster_name
        "ServiceName"    = var.cluster_service
        "FileName"    = "imagedefinitions.json"
        "DeploymentTimeout" = "15"

      }
      input_artifacts = [
        "BuildArtifact",
      ]
      name             = "Deploy"
      output_artifacts = []
      owner            = "AWS"
      provider         = "ECS"
      run_order        = 3
      version          = "1"
    }
  }
}


