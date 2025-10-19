provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "demo" {
  ami = "ami-0bc691261a82b32bc"
    instance_type = "t2.micro"
    subnet_id = "subnet-08fd5ca933492eef7"
    key_name = "eu-west-1-kp"
    vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]

    tags = {
        Name = "DemoInstance"
    }

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host = self.public_ip
      private_key = file("C:/Users/abhin/Downloads/eu-west-1-kp.pem")
    }
    
    provisioner "file" {
      source      = "docker.sh"
      destination = "/home/ubuntu/docker.sh" 
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /home/ubuntu/docker.sh",
            "sudo /home/ubuntu/docker.sh"
        ]
    }
}

output "public_ip" {
  value = aws_instance.demo.public_ip
}