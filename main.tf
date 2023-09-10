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
  access_key    = "my-accesskey"
  secret_key    = "my-secretkey"
}
resource "aws_vpc" "my-vpc" {
    name = myvpc
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
}
resource "aws_subnet" "subnet" {
  name = my-subnent
  vpc_id = aws_vpc.my-vpc
  availability_zone = "us-east-2a"
  cidr_block = [10.0.0.0/24]
}
resource "aws_security_group" "SG" {
    name = my-sg
    depends_on = [ aws_subnet.subnet , aws_vpc.my-vpc ]
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = tcp
        cidr_blocks = [0.0.0.0/0]
    }
    egress {
        from_port = 8080
        to_port = 8080
        cidr_blocks = [0.0.0.0/0] 
        protocol = tcp 
    }
}    