provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "demo" {
    ami = "ami-0bc691261a82b32bc"
    instance_type = "t2.micro"
    subnet_id = "subnet-08fd5ca933492eef7"
    key_name = "eu-west-1-kp"
    vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]
    count = 2

    tags = {
        Name = "DemoInstance"
    }
}