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
  region = ""
  access_key = ""
  secret_key = ""
}

/* 
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  #instance_type = var.instancetype
  #name = var.instancename
  #ami = "ami-02fd062ee104754fc"
  key_name               = "irl-keypair"
  monitoring             = true
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]
}
*/

/*
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = "irl-keypair"
  monitoring             = true
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]
  
}
*/


resource "aws_s3_bucket" "my_bucket" {
  bucket = "abhinavkvd-2"
}

/*
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["1", "2"])

  name = "instance-${each.key}"

  instance_type          = "t2.micro"
  key_name               = "irl-keypair"
  monitoring             = true
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]
  
}
*/

/* resource "aws_instance" "my_instance" {
  ami           = "ami-03cc8375791cb8bcf"  # Ubuntu 24.04 LTS (HVM)
  instance_type = "t2.micro"
  count = 5
  key_name      = "irl-keypair"  # Specify your SSH key pair name here
  monitoring             = true
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]  # my-sg
  #vpc_security_group_ids = ["sg-013ef36435de1738d"]   # django-sg
}
*/

/*
resource "aws_instance" "my_instance_2" {
  ami = "ami-03cc8375791cb8bcf"
  instance_type = "t3.micro"
  count = 4
  key_name = "irl-keypair"
  monitoring = true
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]
  #subnet_id = "subnet-027995a49277edbed"

}
*/