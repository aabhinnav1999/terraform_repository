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

resource "aws_instance" "server" {
    ami = var.ec2_ami
    instance_type = "${var.instance_type}"
    key_name = "irl-keypair"
    monitoring = true
    vpc_security_group_ids = [ "sg-080b2f530b66fd07b" ]

    tags = {
      "Name" = "${var.name}" 
    }
}