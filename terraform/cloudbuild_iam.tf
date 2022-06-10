
resource "aws_s3_bucket" "codebuild" {
  bucket = "codebuildpractice1"
}



resource "aws_iam_role" "example" {
  name = "meetup_demo"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Create an IAM role policy for CodeBuild to use implicitly
resource "aws_iam_role_policy" "codebuild_iam_role_policy" {
  name = "code_build_iam_policy_meetup_demo"
  role = aws_iam_role.example.name

policy = jsonencode({
    "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::meetupdemocodebuild",
        "arn:aws:s3:::meetupdemocodebuild/*",
        "arn:aws:s3:::codepipeline-us-east-2",
        "arn:aws:s3:::codepipeline-us-east-2/*",
        "arn:aws:s3:::codepipelinepractice1",
        "arn:aws:s3:::codepipelinepractice1/*"
       
      ]
    },
    
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:BatchGet*",
        "codecommit:BatchDescribe*",
        "codecommit:Describe*",
        "codecommit:EvaluatePullRequestApprovalRules",
        "codecommit:Get*",
        "codecommit:List*",
        "codecommit:GitPull"
      ],
      "Resource": "arn:aws:codecommit:us-east-2:948612111153:Meetup_DemoPresentation"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:Get*",
        "iam:List*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ecr:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ecs:*",
      "Resource": "*"
    }
  ]
  })
}


# Create IAM role for Terraform builder to assume
resource "aws_iam_role" "tf_iam_assumed_role" {
  name = "TerraformAssumedIamRole"

assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.example.arn}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
  })
}

 

# Create broad IAM policy Terraform to use to build, modify resources
resource "aws_iam_policy" "tf_iam_assumed_policy" {
  name = "TerraformAssumedIamPolicy"
  policy = jsonencode({
    "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowAllPermissions",
      "Effect": "Allow",
      "Action": [
        "*"
      ],
      "Resource": "*"
    }
  ]
  })
}



# Attach IAM assume role to policy
resource "aws_iam_role_policy_attachment" "tf_iam_attach_assumed_role_to_permissions_policy" {
  role       = aws_iam_role.tf_iam_assumed_role.name
  policy_arn = aws_iam_policy.tf_iam_assumed_policy.arn
}