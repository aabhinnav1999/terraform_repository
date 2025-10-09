provider "aws" {
    region = "eu-west-1"
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0bc691261a82b32bc"
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
  
}

resource aws_instance "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = "eu-west-1-kp"
  subnet_id = "subnet-027995a49277edbed"
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]

  tags = {
    Name = "demo-tf-var"
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
}