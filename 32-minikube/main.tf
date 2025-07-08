provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "minikube-server" {

    # ubuntu ami
    ami           = "ami-0df368112825f8d8f" 
    instance_type = "t3.medium"
    key_name      = "my-keypair"
    monitoring = true
    
    # k8s security group
    vpc_security_group_ids = ["sg-012e6ce078d8855b3"] 
    
    
    tags = {
        Name = "minikube-server"
    }
    
    root_block_device {
        volume_size = 20
    }

    connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("C:/Users/abhin/Downloads/my-keypair.pem")
        host        = self.public_ip
    }

    provisioner "file" {
        source = "minikube.sh"
        destination = "/home/ubuntu/minikube.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /home/ubuntu/minikube.sh",
        "/home/ubuntu/minikube.sh"
      ]
    }
}

output "meta-data" {
    value = {
    "name": aws_instance.minikube-server.tags["Name"],
    "public-ip":aws_instance.minikube-server.public_ip,
    "public-dns":aws_instance.minikube-server.public_dns,
    }
}