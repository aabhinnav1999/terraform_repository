provider "aws" {
    region = "eu-west-1"
}

resource "aws_launch_template" "demo-lt" {
    
    name = var.lt_name
    image_id = var.ami_value
    key_name = var.key_pair_name
    instance_type = var.instance_type_value
    vpc_security_group_ids = var.security_group_value

    tags = {
      "Name" = var.lt_tags
    }
}

resource "aws_autoscaling_group" "demo-asg" {

    name = var.name
    max_size = var.max_size
    min_size = var.min_size
    desired_capacity = var.desired_capacity
    availability_zones = var.availability_zones
    target_group_arns = var.target_group_arns_value
    
    launch_template {
        id = aws_launch_template.demo-lt.id
    }

}