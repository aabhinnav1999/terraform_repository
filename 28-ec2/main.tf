
# region eu-west-1

provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "my-server" {

    # ubuntu ami
    ami = "ami-0df368112825f8d8f"

    # change instance type based on requirement 
    instance_type = "t3.small"
    key_name = "eu-west-1-kp"  

    # django security group   
    vpc_security_group_ids = [ "sg-013ef36435de1738d" ]
    monitoring = true

    tags = {
      "Name" = "my-django-server" 
    }

    # installing nginx
    # user_data = <<-EOF
    #             #!/bin/bash
    #             sudo apt update
    #             sudo apt install nginx -y
    #             EOF

}

output "my-server-public-dns" {
    value = aws_instance.my-server.public_dns
}

output "public-ip" {
    value = aws_instance.my-server.public_ip
}

