# Terraform code to create a vpc with private and public subnets.
data "aws_availability_zones" "available" {}

##################
# VPC modules
##################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.env}-polkadot"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  create_igw           = true

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}

resource "aws_security_group_rule" "ssh_inbound" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  description       = "SSH inbound rule"
  cidr_blocks       = ["0.0.0.0/0"] # Adjust this to your security requirements
  security_group_id = "module.vpc.default_security_group_id"
}

