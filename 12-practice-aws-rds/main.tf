terraform {
    required_providers {
      aws ={
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

provider "aws" {
    region = "eu-west-1"
}

resource "aws_security_group" "mysql-sg" {
    ingress  {
        to_port = "3306"
        from_port = "3306"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        to_port = "22"
        from_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "8000"
        to_port = "8000"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        to_port = "80"
        from_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        to_port = 0
        from_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
      "Name" = "database-sg"
    }
}

resource "aws_db_instance" "mysql-db" {
    db_name = "test_mysql_db"
    allocated_storage = 20
    instance_class = "db.t3.micro"
    engine = "mysql"
    engine_version = "8.0.39"
    vpc_security_group_ids = [ aws_security_group.mysql-sg.id ]
    identifier = "django-mysql"         # name of the rds instance
    publicly_accessible = true
    skip_final_snapshot = true
    username = "djangomysql"
    password = "DJANGOmysqladmin"

    tags = {
        "Name" = "django-mysql"
    }
  
}

resource "aws_instance" "ec2-mysql" {
    ami = "ami-03cc8375791cb8bcf"
    key_name = "irl-keypair"
    instance_type = "t3.micro"
    monitoring = true
    vpc_security_group_ids = [aws_security_group.mysql-sg.id]

    tags = {
      "Name" = "django-server" 
    }
}