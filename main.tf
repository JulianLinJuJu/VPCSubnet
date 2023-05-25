terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}

#configure the AWS Provider
provider "aws" {
  region = var.avail_zone
  access_key = "AKIATXF4JQPHSMXABUZT"
  secret_key = "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"
}

# Use variables to reference commonly used data
variable vpc_cidr_blocks {}
variable subnet_cidr_blocks {}
variable avail_zone {}
variable regions {}
variable env_prefix {}


# Create a VPC
resource "aws_vpc" "app-vpc" {
    cidr_block = var.vpc_cidr_blocks
    tags = {
      Name: "${var.env_prefix}-vpc"
    }
}

# Create a Subnet within a VPC
resource "aws_subnet" "app-subnet" {
  vpc_id     = aws_vpc.app-vpc.id
  cidr_block = var.subnet_cidr_blocks
  availability_zone = var.regions[1]
  tags = {
    Name : "${var.env_prefix}-subnet-1"
  }
}