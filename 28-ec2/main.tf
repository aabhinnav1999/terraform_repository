
# region eu-west-1

provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "my-server" {

    # count = 3
    # for_each = {
    #     "instance1" = "subnet-0e2604974ab1b723a"
    #     "instance2" = "subnet-027995a49277edbed"
    #     "instance3" = "subnet-08fd5ca933492eef7"
    # }

    # ubuntu ami
    ami = "ami-0df368112825f8d8f"

    # change instance type based on requirement 
    instance_type = "t3.small"
    key_name = "eu-west-1-kp"  

    # django security group   
    # vpc_security_group_ids = [ "sg-013ef36435de1738d" ]

    # k8s security group
    vpc_security_group_ids = [ "sg-012e6ce078d8855b3" ]

    # subnet_id = each.value
    # subnet_id = element(["subnet-0e2604974ab1b723a", "subnet-027995a49277edbed", "subnet-08fd5ca933492eef7"], count.index % 3)
    

    monitoring = true

    tags = {
      "Name" = "my-server-new" 
    }

    # tags = {
    #     "Name" = subnet_id == "subnet-08fd5ca933492eef7" ? "K3s-master" : "worker-node-${each.key == "instance1" ? 1 : 2}"
    # }

    # installing nginx
    # user_data = <<-EOF
    #             #!/bin/bash
    #             sudo apt update
    #             sudo apt install nginx -y
    #             EOF

    root_block_device {
        volume_size = 20
    }

}

output "public-ip" {
     value = {
        "Name" = aws_instance.my-server.tags["Name"],
        "Public-IP" = aws_instance.my-server.public_ip,
        "Public-DNS" = aws_instance.my-server.public_dns,
    }
 }


