terraform {
    required_providers {
      aws ={
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "jenkins" {

    instance_type = "t3.small"
    ami = "ami-0a422d70f727fe93e"
    key_name = "x23344997"
    monitoring = true
    vpc_security_group_ids = [ "sg-0aca08b1f0a856f8c" ]

    tags = {
      "Name" = "x23344997-jenkins" 
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
                echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
                sudo apt-get update -y
                sudo apt-get install fontconfig openjdk-17-jre -y
                sudo apt-get install jenkins -y
                EOF

    
    disable_api_termination = true
}

output "jenkins-ip" {
    value = aws_instance.jenkins.public_ip
}

resource "aws_instance" "devops" {

    ami = "ami-0a422d70f727fe93e"
    instance_type = "t3.micro"
    monitoring = true
    key_name = "x23344997"
    vpc_security_group_ids = [ "sg-0aca08b1f0a856f8c" ]

    tags = {
      Name = "x23344997-devops"
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt-get install fontconfig openjdk-17-jre -y
                sudo mkdir /home/ubuntu/cicd
                sudo chown -R ubuntu:ubuntu /home/ubuntu/cicd
                sudo apt install python3-venv -y
                sudo apt-get install pkg-config libmysqlclient-dev python3-dev -y
                sudo apt install python3-pip -y
                EOF
}

output "devops-ip" {
  
  value = aws_instance.devops.public_ip
  
}