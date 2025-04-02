terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider

provider "aws" {
  region = "eu-west-1"
  # access_key = ""
  # secret_key = ""
}

/*
variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
  default     = ["subnet-0e2604974ab1b723a", "subnet-027995a49277edbed", "subnet-08fd5ca933492eef7"] 
}

# launching ec2 instances

resource "aws_instance" "instance_1" {
  ami = "ami-03cc8375791cb8bcf"
  instance_type = "t2.nano"
  count = 1
  key_name = "irl-keypair"
  monitoring = true
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]
  subnet_id = element(var.subnet_ids, count.index % length(var.subnet_ids))
  

  tags ={
    Name = "server-${count.index + 1}"
  }
}
*/



# random numbers

/*
provider "random" {}

resource "random_integer" "example" {
  count = length(aws_instance.instance_1)
  min   = 0
  max   = 2
}
output "random_numbers" {
  value = [for r in random_integer.example : r.result]
}
*/

# creating s3 bucket

resource "aws_s3_bucket" "my_bucket" {
  bucket = "kvdabhinav-bucket"
}
