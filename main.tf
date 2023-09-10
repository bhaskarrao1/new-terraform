terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "my-vpc" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name = "myvpc"  # Replace with your desired VPC name
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.0.0/24"  # Specify the CIDR block as a string
  tags = {
    Name = "mysubnet"  # Replace with your desired VPC name
  }
}

resource "aws_security_group" "SG" {
    name = "my-sg"  # Enclose names in double quotes
    depends_on = [aws_subnet.subnet, aws_vpc.my-vpc]
    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
