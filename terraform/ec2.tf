locals {

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    Terraform   = "true"
    Environment = "prd"
  }
}

##################
# EC2 modules
##################


resource "aws_key_pair" "keypair" {
  key_name   = "my-key"
  public_key = file("C:/Users/gregory/.ssh/id_rsa.pub")
}

# Create ec2 instance in private subnet of the AZ1
module "polkadot-az1" {
  source = "terraform-aws-modules/ec2-instance/aws"
  count  = 1
  name   = "polkadot-az1"

  ami                         = var.ami
  instance_type               = "t2.micro" # Replace this with instance type c6i.4xlarge
  key_name                    = aws_key_pair.keypair.key_name
  monitoring                  = true
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true # Attach a public IP address for testing purpose. Instance should be in private subnet and accessed though LB.
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10 # Change to the desired root volume size in GB for creating the instance
    }
  ]

  tags = local.tags
}

# Create ec2 instance in private subnet of the AZ2
module "polkadot-az2" {
  source = "terraform-aws-modules/ec2-instance/aws"
  count  = 1
  name   = "polkadot-az2"

  ami                         = var.ami
  instance_type               = "t2.micro" # Replace this with instance type c6i.4xlarge
  key_name                    = aws_key_pair.keypair.key_name
  monitoring                  = true
  subnet_id                   = module.vpc.public_subnets[1]
  associate_public_ip_address = true # Attach a public IP address
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10 # Change to the desired root volume size in GB for creating the instance
    }
  ]

  tags = local.tags

}

