provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "jenkins-server" {
    ami           = "ami-01f23391a59163da9"
    instance_type = "t3.medium"
    key_name = "my-keypair"
    vpc_security_group_ids = [ "sg-080b2f530b66fd07b" ]

  tags = {
    Name = "Jenkins-Server"
  }
}

output "jenkins_server_ip" {
  value = aws_instance.jenkins-server.public_ip
}

resource "aws_instance" "my-server" {
    ami = "ami-01f23391a59163da9"
    instance_type = "t3.small"
    key_name = "my-keypair"
    vpc_security_group_ids = [ "sg-0cb9fa18187a0b901" ]

    tags = {
      "Name" = "My-Server" 
    }
}

output "my_server_ip" {
  value = aws_instance.my-server.public_ip
}
