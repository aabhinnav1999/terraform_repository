provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "tf-vpc" {
    cidr_block = "19.19.0.0/16"

    tags = {
        Name = "tf-vpc"
    }
}

resource "aws_subnet" "tf-public-1a" {
    vpc_id = aws_vpc.tf-vpc.id
    cidr_block = "19.19.9.0/24"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true

    tags = {
      "Name" = "tf-public-1a" 
    }
}

resource "aws_subnet" "tf-public-1b" {
    vpc_id = aws_vpc.tf-vpc.id
    cidr_block = "19.19.27.0/24"
    availability_zone = "eu-west-1b"
    map_public_ip_on_launch = true

    tags = {
      "Name" = "tf-public-1b" 
    }
}

resource "aws_subnet" "tf-private-1a" {
    vpc_id = aws_vpc.tf-vpc.id
    cidr_block = "19.19.45.0/24"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = false   

    tags ={
        "Name" = "tf-private-1a"
    } 
  
}

resource "aws_subnet" "tf-private-1b" {
    vpc_id = aws_vpc.tf-vpc.id
    cidr_block = "19.19.54.0/24"
    availability_zone = "eu-west-1b"
    map_public_ip_on_launch = false   

    tags ={
        "Name" = "tf-private-1b"
    } 
  
}

resource "aws_security_group" "tf-sg" {

    vpc_id = aws_vpc.tf-vpc.id
    name = "tf-sg"

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp" 
        to_port = "22"
        from_port = "22"
    }

    egress {
        cidr_blocks = [ "0.0.0.0/0" ]
        protocol = "-1"
        to_port = 0
        from_port = 0
    }

    tags = {
      "Name" = "tf-sg" 
    }
  
}


resource "aws_instance" "tf-instance" {
    ami = "ami-01f23391a59163da9"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.tf-public-1b.id
    vpc_security_group_ids = [ aws_security_group.tf-sg.id ]
    key_name = "eu-west-1-kp"

    # default
    # vpc_security_group_ids = [ "sg-075a13daa362c53bf" ]

    tags = {
      "Name" = "tf-instance"
    }
}

resource "aws_internet_gateway" "tf-igw" {
    vpc_id = aws_vpc.tf-vpc.id

    tags = {
      "Name" = "tf-igw" 
    }
}

resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.tf-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.tf-igw.id
    }

    tags = {
      "Name" = "public-rt"
    }
}

resource "aws_route_table_association" "rta-public-1a" {
    subnet_id = aws_subnet.tf-public-1a.id
    route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "rta-public-1b" {
    subnet_id = aws_subnet.tf-public-1b.id
    route_table_id = aws_route_table.public-rt.id 
}

resource "aws_instance" "tf-ins-private" {

    ami = "ami-01f23391a59163da9"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.tf-private-1b.id
    vpc_security_group_ids = [ aws_security_group.tf-sg.id ]
    key_name = "eu-west-1-kp"

    tags = {
      "Name" = "tf-ins-private" 
    }
}

resource "aws_eip" "eip-1" {
    tags = {
        "Name" = "eip-1"
    }  
}

resource "aws_nat_gateway" "nat-1" {
    subnet_id = aws_subnet.tf-public-1a.id
    allocation_id = aws_eip.eip-1.id

    tags = {
      "Name" = "nat-1" 
    }
}

resource "aws_route_table" "private-rt-1" {
    vpc_id = aws_vpc.tf-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat-1.id
    }

    tags = {
      "Name" = "private-rt-1" 
    }
}

resource "aws_route_table_association" "rta-private-1" {
    subnet_id = aws_subnet.tf-private-1a.id
    route_table_id = aws_route_table.private-rt-1.id
}

resource "aws_eip" "eip-2" {
    tags = {
        "Name" = "eip-2"
    }  
}

resource "aws_nat_gateway" "nat-2" {
    subnet_id = aws_subnet.tf-public-1b.id
    allocation_id = aws_eip.eip-2.id

    tags = {
      "Name" = "nat-2" 
    }
}

resource "aws_route_table" "private-rt-2" {
    vpc_id = aws_vpc.tf-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat-2.id
    }

    tags = {
      "Name" = "private-rt-2" 
    }
}

resource "aws_route_table_association" "rta-private-2" {
    subnet_id = aws_subnet.tf-private-1b.id
    route_table_id = aws_route_table.private-rt-2.id
}

resource "aws_instance" "tf-ins-private-2" {

    ami = "ami-01f23391a59163da9"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.tf-private-1a.id
    vpc_security_group_ids = [ aws_security_group.tf-sg.id ]
    key_name = "eu-west-1-kp"

    tags = {
      "Name" = "tf-ins-private-2" 
    }
}