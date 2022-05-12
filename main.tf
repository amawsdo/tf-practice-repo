terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

/*
resource "aws_instance" "test-ec2" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_1.id
  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "deep-master"
  }
}
*/

/*module "deep_vpc" {
  source = "./terraform-aws-vpc"
}
*/
