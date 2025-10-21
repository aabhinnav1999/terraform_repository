provider "aws" {
    region = "eu-west-1"
}

resource "aws_vpc" "terraform_vpc" {
    cidr_block = "10.19.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "terraform-vpc"
    }
}

resource "aws_subnet" "tf_public_subnet" {
    vpc_id            = aws_vpc.terraform_vpc.id
    cidr_block        = "10.19.0.0/20"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true
    

    tags = {
        Name = "tf-public-subnet"
    }
}

resource "aws_subnet" "tf_private_subnet" {
    vpc_id            = aws_vpc.terraform_vpc.id
    cidr_block        = "10.19.99.0/24"
    availability_zone = "eu-west-1b"
    map_public_ip_on_launch = false

    tags = {
      Name = "tf-private-subnet" 
    }
}

resource "aws_route_table" "tf_public_rt" {
    vpc_id = aws_vpc.terraform_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.tf_igw.id
    }

    tags = {
        Name = "tf-public-rt"
    }
  
}

resource "aws_route_table_association" "tf_public_rt_association" {
    subnet_id      = aws_subnet.tf_public_subnet.id
    route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_internet_gateway" "tf_igw" {
    vpc_id = aws_vpc.terraform_vpc.id

    tags = {
        Name = "tf-igw"
    }
}

resource "aws_security_group" "tf_sg" {
    name        = "tf-sg"
    description = "Allow SSH and HTTP"
    vpc_id      = aws_vpc.terraform_vpc.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "tf-sg"
    }
}

resource "aws_instance" "tf_public_instance" {
    ami           = "ami-0bc691261a82b32bc" 
    instance_type = "t3.micro"
    subnet_id     = aws_subnet.tf_public_subnet.id
    key_name = "webserver-kp"
    vpc_security_group_ids = [ aws_security_group.tf_sg.id ]

    tags = {
        Name = "tf-public-instance"
    }
}

resource "aws_instance" "tf_private_instance" {
    ami           = "ami-0bc691261a82b32bc" 
    instance_type = "t3.micro"
    subnet_id     = aws_subnet.tf_private_subnet.id
    vpc_security_group_ids = [ aws_security_group.tf_sg.id ]
    key_name = "webserver-kp"

    tags = {
        Name = "tf-private-instance"
    } 
}

resource "aws_nat_gateway" "tf_nat_gateway" {
  allocation_id = aws_eip.tf_eip.id
  subnet_id     = aws_subnet.tf_public_subnet.id

  tags = {
    Name = "tf-nat-gateway"
  }
}

resource "aws_eip" "tf_eip" {

  tags = {
    Name = "tf-eip"
  }
}

resource "aws_route_table" "tf_private_rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf_nat_gateway.id
    }

    tags = {
      Name = "tf-private-rt"
    }
}

resource "aws_route_table_association" "tf_private_rt_association" {
  subnet_id      = aws_subnet.tf_private_subnet.id
  route_table_id = aws_route_table.tf_private_rt.id
}