provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.security_groups
    key_name = var.key_name

    tags = {
        Name = var.Name
    }
}