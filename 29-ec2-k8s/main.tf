provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "control_plane" {

    ami = "ami-0df368112825f8d8f"
    vpc_security_group_ids = [ "sg-012e6ce078d8855b3" ]
    instance_type = "t3.medium"
    key_name = "eu-west-1-kp"
    monitoring = true

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

}

output "control_plane-public-ip" {
    value = [aws_instance.control_plane.public_dns, aws_instance.control_plane.public_ip]
}

resource "aws_instance" "worker_node" {
  for_each = toset(["1", "2", "3"])

  ami = "ami-0df368112825f8d8f"
  vpc_security_group_ids = ["sg-012e6ce078d8855b3"]
  instance_type = "t3.small"
  key_name = "eu-west-1-kp"
  monitoring = true

  tags = {
    "Name" = "worker-node-${each.key}"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Running setup on worker node ${each.key}"
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
  value = [for instance in aws_instance.worker_node : instance.public_dns]
}