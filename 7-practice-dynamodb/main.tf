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

resource "aws_dynamodb_table" "example_1" {
    name = "usertable"
    billing_mode = "PROVISIONED"
    read_capacity = 5
    write_capacity = 5
    # hash_key = "EID"

    # attribute {
    #   name = "EID"
    #   type = "S"
    # }

    tags = {
        Name="usertable"
        # Environment="development"
    }
}