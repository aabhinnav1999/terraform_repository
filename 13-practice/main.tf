terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "instance-1" {

    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t3.micro"
    vpc_security_group_ids = [ "sg-0cb9fa18187a0b901" ]
    key_name = "irl-keypair"
    monitoring = true

    tags = {
      "Name" = "terraform-1" 
    }
}

output "instance-1-ip" {
    value = aws_instance.instance-1.public_ip
}