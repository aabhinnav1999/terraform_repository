provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "demo-instance" {
    
    ami = var.ami_value
    instance_type = var.instance_type_value
    key_name = var.key_pair_name
    vpc_security_group_ids =  var.security_group_value 
    monitoring = var.monitoring
    availability_zone = var.availability_zone
    disable_api_stop = var.disable_stop
    disable_api_termination = var.disable_termination

    tags = {
      "Name" = var.instance_name
    }

}