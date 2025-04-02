terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
  region = ""
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "instance-1" {
    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t3.micro"
    key_name      = "irl-keypair"
    monitoring             = true
    vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]
    count=2
}

/*
resource "aws_ec2_instance_state" "instance-1" {
  instance_id = aws_instance.instance-1.id
  state       = "stopped"
}
*/

/*
resource "aws_instance" "jenkins_instance" {
    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t3.micro"
    key_name = "irl-keypair"
    monitoring = true
    tags ={
    Name = "jenkins-server"
    }
    vpc_security_group_ids = ["sg-080b2f530b66fd07b"]
}
*/