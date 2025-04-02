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

# resource "aws_instance" "docker-server" {

#     ami = "ami-03cc8375791cb8bcf"
#     instance_type = "t2.micro"
#     monitoring = true
#     key_name = "irl-keypair"
#     vpc_security_group_ids = [ "sg-080b2f530b66fd07b" ]
    
#     tags = {
#       "Name" = "docker-server" 
#     }

#     user_data = <<-EOF
#                 #!/bin/bash
#                 sudo apt-get update -y
#                 sudo apt-get install ca-certificates curl -y
#                 sudo install -m 0755 -d /etc/apt/keyrings 
#                 sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
#                 sudo chmod a+r /etc/apt/keyrings/docker.asc
#                 echo \
#                 "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
#                 $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
#                 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#                 sudo apt-get update -y
#                 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
#                 EOF
# }

# output "docker_ip_address" {
#     value = aws_instance.docker-server.public_ip
#     description = "The public IP address of the docker instance"
# }

resource "aws_instance" "sonarqube" {
    ami = "ami-03cc8375791cb8bcf"
    key_name = "irl-keypair"
    monitoring = true
    instance_type = "t2.micro"
    vpc_security_group_ids = [ "sg-0cb9fa18187a0b901"]

    tags = {
      "Name" = "sonarqube" 
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y ca-certificates curl
                sudo install -m 0755 -d /etc/apt/keyrings
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
                sudo chmod a+r /etc/apt/keyrings/docker.asc -y
                echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt-get update -y
                sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
                EOF
}

output "sonarqube-ip-address" {
    value = aws_instance.sonarqube.public_ip
}