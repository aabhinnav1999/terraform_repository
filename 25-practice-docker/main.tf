provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "docker-server" {
    ami = "ami-03fd334507439f4d1"
    key_name = "irl-keypair"
    instance_type = "t3.small"
    vpc_security_group_ids = [ "sg-012e6ce078d8855b3" ]
    monitoring = true

    tags = {
      "Name" = "docker-server" 
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install ca-certificates curl -y
                sudo install -m 0755 -d /etc/apt/keyrings
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
                sudo chmod a+r /etc/apt/keyrings/docker.asc
                echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt-get update
                sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin -y
                EOF

    # connection {
    #   type = "ssh"
    #   user = "ubuntu"
    #   private_key = file("C:/Users/abhin/Downloads/irl-keypair.pem")
    #   host = self.public_ip
    # }

    # provisioner "file" {
    #     source = "index.html"
    #     destination = "/home/ubuntu/index.html"
    # }

    # provisioner "file" {
    #     source = "dockerfile"
    #     destination = "/home/ubuntu/dockerfile"
    # }
}

output "docker-ip" {
    value = aws_instance.docker-server.public_ip
}

# resource "aws_ecr_repository" "my-repo" {
#     name = "django-repo"
#     image_tag_mutability = "MUTABLE"
# }