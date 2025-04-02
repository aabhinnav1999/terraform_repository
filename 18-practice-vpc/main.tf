provider "aws" {
    region = "eu-west-1"
}

resource "aws_vpc" "demo-vpc" {
    cidr_block = "172.19.0.0/16"

    tags = {
      "Name" = "terraform-vpc" 
    }
}

resource "aws_subnet" "demo-subnet-public" {
    vpc_id = aws_vpc.demo-vpc.id

    cidr_block = "172.19.1.0/24"
    availability_zone = "eu-west-1c"

    map_public_ip_on_launch = true

    tags = {
      "Name" = "terraform-public-1" 
    }

}

resource "aws_subnet" "demo-subnet-private" {
    vpc_id = aws_vpc.demo-vpc.id

    cidr_block = "172.19.2.0/24"
    availability_zone = "eu-west-1c"

    tags = {
      "Name" = "terraform-private-1" 
    }
}

resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demo-vpc.id

    tags = {
      "Name" = "terraform-igw" 
    }
}

resource "aws_route_table" "demo-rtb" {
    vpc_id = aws_vpc.demo-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
    }

    tags = {
      "Name" = "terraform-rtb"
    }
}

resource "aws_route_table_association" "demo-rtb-assoc" {
    route_table_id = aws_route_table.demo-rtb.id
    subnet_id = aws_subnet.demo-subnet-public.id
}

resource "aws_instance" "demo-instance" {
    
    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t2.micro"
    monitoring = true
    key_name = "irl-keypair"
    vpc_security_group_ids = [aws_security_group.demo-sg.id]
    subnet_id = aws_subnet.demo-subnet-public.id

    tags = {
      "Name" = "terraform-server"
    }
}

resource "aws_security_group" "demo-sg" {
    
    name = "terraform-sg"
    vpc_id = aws_vpc.demo-vpc.id
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      "Name" = "terraform-sg"
    }
}