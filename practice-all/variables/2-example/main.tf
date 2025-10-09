provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = "eu-west-1-kp"
  subnet_id = "subnet-027995a49277edbed"
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]

  tags = {
    Name = "demo-tf-var"
  }
  
}