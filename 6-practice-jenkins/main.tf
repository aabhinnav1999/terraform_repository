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

    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t2.nano"
    key_name = "irl-keypair"
    monitoring = true
    vpc_security_group_ids = [ aws_security_group.tf-jenkins.id]

    tags = {
      Name = "jenkins-test"
    }

    root_block_device {
      volume_size = 20
    }
    
    user_data = <<-EOF
                #!/bin/bash
                sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
                echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
                sudo apt-get update -y
                sudo apt-get install fontconfig openjdk-17-jre -y
                sudo apt-get install jenkins -y
                EOF
}

resource "aws_eip" "jenkins_eip" {
    domain = "vpc"
}

resource "aws_eip_association" "jenkins_eip_assoc" {
    instance_id = aws_instance.jenkins.id
    allocation_id = aws_eip.jenkins_eip.id
}

output "jenkins_instance_public_ip" {
    value = aws_eip.jenkins_eip.public_ip
}

resource "aws_security_group" "tf-jenkins" {
  name = "tf-jenkins"
  vpc_id = "vpc-098619d88bf464cbe"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_instance" "ansible" {

    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t2.nano"
    monitoring = true
    key_name = "irl-keypair"
    vpc_security_group_ids = [ aws_security_group.tf-ansible.id ]

    tags = {
      "Name" = "ansible-test" 
    }

}

resource "aws_eip" "ansible_eip" {
    domain = "vpc"
  
}

resource "aws_eip_association" "ansible_eip_assoc" {
    instance_id = aws_instance.ansible.id
    allocation_id = aws_eip.ansible_eip.id
}

output "ansible_instance_public_ip" {
    value = aws_eip.ansible_eip.public_ip
  
}

resource "aws_security_group" "tf-ansible" {
  name = "tf-ansible"
  vpc_id = "vpc-098619d88bf464cbe"

  ingress {
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    to_port = 0
    from_port = 0
    protocol = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
}
