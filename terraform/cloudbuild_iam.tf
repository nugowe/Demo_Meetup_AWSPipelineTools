
data "aws_iam_role" "codebuild" {
  name = "meetup_demo"
}


data "aws_iam_role" "tf_iam_assumed_role" {
  name = "TerraformAssumedIamRole"
}

data "aws_iam_role" "tf_iam_assumed_policy" {
  name = "TerraformAssumedIamPolicy"
}





# Attach IAM assume role to policy
resource "aws_iam_role_policy_attachment" "tf_iam_attach_assumed_role_to_permissions_policy" {
  role       = data.aws_iam_role.tf_iam_assumed_role.name
  policy_arn = data.aws_iam_policy.tf_iam_assumed_policy.arn
}