provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "eks-server" {

    # ubuntu ami
    ami           = "ami-0df368112825f8d8f" 
    instance_type = "t3.small"
    key_name      = "eu-west-1-kp"
    monitoring = true
    
    # k8s security group
    vpc_security_group_ids = ["sg-012e6ce078d8855b3"] 
    
    
    tags = {
        Name = "eks-server"
    }
    
    root_block_device {
        volume_size = 20
    }

    connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("C:/Users/abhin/Downloads/eu-west-1-kp.pem")
        host        = self.public_ip
    }

    provisioner "file" {
        source = "eks.sh"
        destination = "/home/ubuntu/eks.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /home/ubuntu/eks.sh",
        "/home/ubuntu/eks.sh"
      ]
    }
}

output "meta-data" {
    value = {
    "name": aws_instance.eks-server.tags["Name"],
    "public-ip":aws_instance.eks-server.public_ip,
    "public-dns":aws_instance.eks-server.public_dns,
    }
}