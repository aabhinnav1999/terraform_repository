provider "aws" {
    alias = "us-east-1"
    region = "us-east-1"  
}

provider "aws" {
    alias = "eu-west-1"
    region = "eu-west-1"
}

data "aws_availability_zones" "us-east" {
    provider = aws.us-east-1
}

data "aws_availability_zones" "eu-west" {
    provider = aws.eu-west-1
}

resource "aws_instance" "us-east" {

    provider = aws.us-east-1
    count = 5
    ami = "ami-0e2c8caa4b6378d8c"
    key_name = "us-east-1"
    instance_type = "t2.nano"
    monitoring = true  

    availability_zone = element(data.aws_availability_zones.us-east.names, count.index % length(data.aws_availability_zones.us-east.names))  

    tags = {
      "Name" = "web-server-${count.index+1}" 
    }
}

resource "aws_instance" "eu-west" {
    
    provider = aws.eu-west-1
    count = 5
    ami = "ami-03cc8375791cb8bcf"
    key_name = "irl-keypair"
    instance_type = "t2.nano"
    monitoring = true

    availability_zone = element(data.aws_availability_zones.eu-west.names, count.index % length(data.aws_availability_zones.eu-west.names))    

    tags = {
      "Name" = "web-server-${count.index+1}" 
    }
}