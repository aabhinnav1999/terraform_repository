provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "kubernetes-node-instances" {
    count = 2
    ami = "ami-03fd334507439f4d1"
    instance_type = "t2.small"
    key_name = "irl-keypair"
    vpc_security_group_ids = [ "sg-012e6ce078d8855b3" ]
    monitoring = true

    tags = {
      "Name" = "k8s-node-${count.index+1}" 
    }

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("C:/Users/abhin/Downloads/irl-keypair.pem")
        host = self.public_ip
    }

    provisioner "file" {
        source = "kube.sh"
        destination = "/home/ubuntu/kube.sh"
    }

    user_data = <<-EOF
                #!/bin/bash
                cd /home/ubuntu
                sudo chmod +x kube.sh
                ./kube.sh
                sudo kubeadm join 172.31.27.76:6443 --token 7321uf.4tsf7imdzdlhbmwq --discovery-token-ca-cert-hash sha256:5b2b67ca24e52c16263492e3217764f2025342f101912c89f273cb12c6ff34e7
                EOF
}

resource "aws_instance" "kubernetes-master-node" {

    ami = "ami-03fd334507439f4d1"
    instance_type = "t3.small"
    key_name = "irl-keypair"
    vpc_security_group_ids = [ "sg-012e6ce078d8855b3" ]
    monitoring = true

    tags = {
      "Name" = "k8s-master" 
    }

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("C:/Users/abhin/Downloads/irl-keypair.pem")
        host = self.public_ip
    }

    provisioner "file" {
        source = "kube.sh"
        destination = "/home/ubuntu/kube.sh"
    }

    provisioner "file" {
        source = "kubenetwork.sh"
        destination = "/home/ubuntu/kubenetwork.sh"
    }

    user_data = <<-EOF
                #!/bin/bash
                cd /home/ubuntu
                sudo chmod +x kube.sh
                sudo chmod +x kubenetwork.sh
                ./kube.sh
                ./kubenetwork.sh
                EOF
}

output "k8s-master-ip" {
    value = aws_instance.kubernetes-master-node.public_ip
}