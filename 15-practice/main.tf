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

resource "aws_instance" "jenkins-server" {

    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t3.small"
    key_name = "irl-keypair"
    monitoring = true
    vpc_security_group_ids = [ "sg-080b2f530b66fd07b" ]

    tags = {
      "Name" = "jenkins-server" 
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
                echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
                sudo apt-get update -y
                sudo apt-get install fontconfig openjdk-17-jre -y
                sudo apt-get install jenkins -y
                sudo apt-get install nginx -y
                EOF
}

output "jenkins-ip" {
    value = aws_instance.jenkins-server.public_ip
}

resource "aws_instance" "django" {

    ami = "ami-03cc8375791cb8bcf"
    monitoring = true
    key_name = "irl-keypair"
    instance_type = "t3.micro"
    vpc_security_group_ids = [ "sg-013ef36435de1738d" ]

    tags = {
      "Name" = "django-server" 
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install nginx -y
                EOF
  
}