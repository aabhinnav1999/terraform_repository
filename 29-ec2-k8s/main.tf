provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "control_plane" {

    ami = "ami-0df368112825f8d8f"
    vpc_security_group_ids = [ "sg-012e6ce078d8855b3" ]
    instance_type = "t3.medium"
    key_name = "eu-west-1-kp"
    monitoring = true
    subnet_id = "subnet-027995a49277edbed"

    tags = {
      "Name" = "control-plane" 
    }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/abhin/Downloads/eu-west-1-kp.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "scripts.sh"
    destination = "/home/ubuntu/scripts.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/scripts.sh",
      "/home/ubuntu/scripts.sh"
    ]
  }

  root_block_device {
    volume_size = 20
  }

}



output "control_plane-public-ip" {
    value = [aws_instance.control_plane.public_dns, aws_instance.control_plane.public_ip]
}

resource "aws_instance" "worker_node" {
  
  for_each = {
        "1" = "subnet-0e2604974ab1b723a"
        "2" = "subnet-08fd5ca933492eef7"
        "3" = "subnet-027995a49277edbed"
    }

  ami = "ami-0df368112825f8d8f"
  vpc_security_group_ids = ["sg-012e6ce078d8855b3"]
  instance_type = "t3.micro"
  key_name = "eu-west-1-kp"
  subnet_id = each.value
  monitoring = true

  tags = {
    "Name" = "worker-node-${each.key}"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Running setup on worker node ${each.key}"
              hostnamectl set-hostname "worker-node-${each.key}"
            EOF

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/abhin/Downloads/eu-west-1-kp.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "in_setup.sh"
    destination = "/home/ubuntu/in_setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/in_setup.sh",
      "/home/ubuntu/in_setup.sh"
    ]
  }
}


output "worker_node_public_ips" {
  value = [for instance in aws_instance.worker_node : {
    "name": instance.tags["Name"],
    "public-ip":instance.public_ip,
    "public-dns":instance.public_dns,
    }]
}