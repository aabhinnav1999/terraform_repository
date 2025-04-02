terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider

provider "aws" {
  region = "eu-west-1"
  # access_key = ""
  # secret_key = ""
}

resource "aws_instance" "ansible_instance" {

    ami = "ami-03cc8375791cb8bcf"
    instance_type="t2.micro"
    key_name="irl-keypair"
    monitoring = true
    vpc_security_group_ids=["sg-0cb9fa18187a0b901"]
    disable_api_stop = false                            # false means no stop/terminate protection 
    disable_api_termination = false
    #count=1

    tags ={
    Name = "ansible-server"
  }


}

# resource "aws_instance" "jenkins_instance" {
#   ami = "ami-03cc8375791cb8bcf"
#   instance_type="t3.micro"
#   key_name="irl-keypair"
#   monitoring = true
#   vpc_security_group_ids=["sg-080b2f530b66fd07b"]
#   #count=1

#   tags={
#     Name="jenkins-server"
#   }
# }

/*
resource "aws_ec2_instance_state" "ansible_instance"{
  instance_id=aws_instance.ansible_instance.id
  state = "running"
} 

resource "aws_ec2_instance_state" "jenkins_instance" {
  instance_id=aws_instance.jenkins_instance.id
  state = "running"
}
*/