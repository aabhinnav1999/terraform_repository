provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "private-1" {
    
    ami = "ami-0e9085e60087ce171"
    instance_type = "t2.micro"
    key_name = "irl-keypair"
    vpc_security_group_ids =  [aws_security_group.aws-demo-sg.id]
    subnet_id = "subnet-08d754bbb06f52acc"
    monitoring = true
    

    tags = {
      "Name" = "aws-demo-private-1"
    }
}

resource "aws_security_group" "aws-demo-sg" {
    
    vpc_id = "vpc-0ca0d8859608f089d"

    ingress {
        to_port = 22
        from_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        to_port = 80
        from_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        to_port = 90
        from_port = 90
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        to_port = 0
        from_port = 0
        protocol = -1
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      "Name" = "aws-demo-sg" 
    }
}

resource "aws_instance" "private-2" {
    
    ami = "ami-0e9085e60087ce171"
    instance_type = "t2.micro"
    key_name = "irl-keypair"
    vpc_security_group_ids =  [aws_security_group.aws-demo-sg.id]
    subnet_id = "subnet-0d5415028267ea85e"
    monitoring = true
    

    tags = {
      "Name" = "aws-demo-private-2"
    }
}

resource "aws_instance" "public" {
    
    ami = "ami-0e9085e60087ce171"
    instance_type = "t2.micro"
    key_name = "irl-keypair"
    vpc_security_group_ids =  [aws_security_group.aws-demo-sg.id]
    subnet_id = "subnet-0787e2d5a8ca5024f"
    monitoring = true
    associate_public_ip_address = true
    

    tags = {
      "Name" = "aws-demo-public"
    }

}