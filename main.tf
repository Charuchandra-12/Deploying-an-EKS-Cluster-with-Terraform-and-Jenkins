# VPC
module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = "jenkins-vpc"
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.azs.names
  public_subnets       = var.public_subnets
  enable_dns_hostnames = true
  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
  public_subnet_tags = {
    Name = "jenkins-public-subnet"
  }
}

# Security Group
module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "jenkins-sg"
  description = "Security group for Jenkins Server"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP Port"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 20
      to_port     = 20
      protocol    = "tcp"
      description = "SSH Port"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "jenkins-sg"
  }
}

# EC2
module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  name                        = "jenkins-instance"
  instance_type               = var.instance_type
  key_name                    = "ssh-key"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Name        = "jenkins-server"
    Terraform   = "true"
    Environment = "dev"
  }
}