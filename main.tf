terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


resource "aws_vpc" "my-vpc" {
    name = "myvpc"  # Enclose names in double quotes
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
}

resource "aws_subnet" "subnet" {
  name = "my-subnet"  # Enclose names in double quotes
  vpc_id = aws_vpc.my-vpc.id
  availability_zone = "us-east-2a"
  cidr_block = "10.0.0.0/24"  # Specify the CIDR block as a string
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