terraform {
  backend "s3" {
    bucket = "terraform-eks-jenkins-project"
    key    = "eks/terraform.tfsate"
    region = "us-east-1"
  }
}