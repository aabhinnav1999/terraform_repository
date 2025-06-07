provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "k3s-master" {
    
    ami = "ami-03fd334507439f4d1"
    instance_type = "t3.medium"
    key_name = "eu-west-1-kp"
    vpc_security_group_ids = [ "sg-012e6ce078d8855b3" ]
    subnet_id = "subnet-027995a49277edbed"
    monitoring = true

    tags = {
      "Name" = "k3s-master" 
    }

    root_block_device {
      volume_size = 20
    }
}

output "master-ip" {
    value = {
    "name": aws_instance.k3s-master.tags["Name"],
    "public-ip":aws_instance.k3s-master.public_ip,
    "public-dns":aws_instance.k3s-master.public_dns,
    }
}

resource "aws_instance" "k3s-worker" {
    
    for_each = {
        "1" = "subnet-0e2604974ab1b723a"
        "2" = "subnet-08fd5ca933492eef7"
    }

    ami = "ami-03fd334507439f4d1"
    instance_type = "t3.small"
    key_name = "eu-west-1-kp"
    vpc_security_group_ids = [ "sg-012e6ce078d8855b3" ]
    monitoring = true

    subnet_id = each.value

    tags = {
    "Name" = "k3s-worker-${each.key}"
  }
}

output "k3s-worker_node_ips" {
  value = [for instance in aws_instance.k3s-worker : {
    "name": instance.tags["Name"],
    "public-ip":instance.public_ip,
    "public-dns":instance.public_dns,
    }]
}