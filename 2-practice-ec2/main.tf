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

resource "aws_instance" "my-server" {
    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t3.medium"
    key_name = "irl-keypair"
    monitoring = true
    vpc_security_group_ids = [ "sg-0cb9fa18187a0b901" ]
    # count=2

    tags = {
      "Name" = "django-server"
    }
}

# output "ip-address" {
#     value = aws_instance.my-server.public_ip
# }