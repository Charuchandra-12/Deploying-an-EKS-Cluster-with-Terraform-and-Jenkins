terraform {
  backend "s3" {
    bucket = "terraform-eks-jenkins-project"
    key    = "jenkins/terraform.tfsate"
    region = "us-east-1"
  }
}

