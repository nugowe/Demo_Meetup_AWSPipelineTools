terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "demo-meetup-awspipeline-tools-state-files"
    key     = "demo-meetup-awspipeline-tools-state-files"
    encrypt = true #AES-256encryption
  }
}