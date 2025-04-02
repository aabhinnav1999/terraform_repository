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
    ami="ami-03cc8375791cb8bcf"
    instance_type = "t3.medium"
    key_name = "irl-keypair"
    monitoring = true
    vpc_security_group_ids = [ "sg-080b2f530b66fd07b" ]

    tags = {
      "Name" = "jenkins-server" 
    }

root_block_device {
    volume_size = 10
}

user_data = <<-EOF
            #!/bin/bash
            sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
            https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
            echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
            https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
            /etc/apt/sources.list.d/jenkins.list > /dev/null
            sudo apt-get update -y
            sudo apt-get install fontconfig openjdk-17-jre -y
            sudo apt-get install jenkins -y
            EOF

}

resource "aws_eip" "jenkins_eip" {
    domain = "vpc"
}

resource "aws_eip_association" "jenkins_eip_assoc" {
    instance_id = aws_instance.jenkins-server.id
    allocation_id = aws_eip.jenkins_eip.id
}

output "jenkins-ip" {
    value = aws_eip.jenkins_eip.public_ip
}

resource "aws_instance" "ansible-server" {
    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t3.micro"
    key_name = "irl-keypair"
    monitoring = true
    vpc_security_group_ids = [ "sg-0cb9fa18187a0b901" ]
    iam_instance_profile = "ansible_ec2_role"
    # availability_zone = "eu-west-1a"

    tags = {
      Name = "ansible-server" 
    }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt-get install fontconfig openjdk-17-jre -y
              sudo apt install software-properties-common -y
              sudo add-apt-repository --yes --update ppa:ansible/ansible
              sudo apt install ansible -y
              sudo mkdir -p /home/ubuntu/jenkins_folder
              sudo chown -R ubuntu:ubuntu /home/ubuntu/jenkins_folder
              sudo apt install python3-boto3 python3-botocore
              EOF
}

output "ansible-ip" {
    value = aws_instance.ansible-server.public_ip
}
