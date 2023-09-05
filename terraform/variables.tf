variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "env" {
  type    = string
  default = "prd"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "ami" {
  description = "Ubuntu, 22.04 LTS ami"
  type        = string
  default     = "ami-01dd271720c1ba44f"
}