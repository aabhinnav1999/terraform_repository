provider "aws" {
    region = "eu-west-1"
}

data "aws_availability_zones" "available" {}

resource "aws_instance" "example-1" {

    count=9
    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t2.nano"
    key_name = "irl-keypair"
    monitoring = true
    vpc_security_group_ids = [ "sg-013ef36435de1738d" ]
    availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))

    tags = {
      "Name" = "web-server-${count.index+1}" 
    }

}