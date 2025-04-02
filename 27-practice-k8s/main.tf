provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "k8s-instance" {
    
    ami = "ami-03fd334507439f4d1"
    instance_type = "t3.small"
    key_name = "irl-keypair"
    vpc_security_group_ids = [ "sg-012e6ce078d8855b3" ]
    monitoring = true

    tags = {
      "Name" = "k8s-master" 
    }
}

output "k8s-ip" {
    value = aws_instance.k8s-instance.public_ip
}