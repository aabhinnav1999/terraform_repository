provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "demo" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    key_name = var.key_name
    vpc_security_group_ids = var.vpc_security_group_ids

    tags = {
        for key, value in var.tags : key => value
    }
}