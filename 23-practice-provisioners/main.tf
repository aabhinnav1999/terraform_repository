provider "aws" {    
    region = "eu-west-1"
}

resource "aws_instance" "demo-instance" {

    ami = "ami-0e9085e60087ce171"
    monitoring = true
    instance_type = "t2.nano"
    key_name = "irl-keypair"
    vpc_security_group_ids = [ "sg-013ef36435de1738d" ]
    availability_zone = "eu-west-1b"

    tags = {
      "Name" = "demo-instance" 
    }

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("C:/Users/abhin/Downloads/irl-keypair.pem")
      host = self.public_ip
    }

    provisioner "file" {
        source = "main.tf"
        destination = "/home/ubuntu/main.tf"
    }

    provisioner "remote-exec" {
        inline = [ 
            "echo 'Hello from the remote instance'",
            "sudo apt update -y",
            "sudo apt-get install -y python3-pip",
            "sudo apt install nginx -y"
         ]
    }

    provisioner "local-exec" {
        command = "echo ${self.private_ip} >> private_ip.txt"
    }
}


output "instance-ip" {
    value = aws_instance.demo-instance.public_ip
}