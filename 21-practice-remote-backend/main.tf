provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "instance-1" {
    
    ami = "ami-0e9085e60087ce171"
    instance_type = "t2.micro"
    key_name = "irl-keypair"

    tags = {
      "Name" = "instance-1" 
    }
}

resource "aws_dynamodb_table" "demo-table" {
    name="demo-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "emp"

    attribute {
      name = "emp"
      type = "S"   
    }  
}

