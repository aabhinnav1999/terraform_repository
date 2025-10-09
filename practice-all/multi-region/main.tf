provider "aws" {
    region = "eu-west-1"
    alias = "dublin"
}

provider "aws" {
    region = "ap-south-2"
    alias = "hyderabad"
}

resource "aws_instance" "eu_west_1" {
  provider = aws.dublin
  ami           = "ami-0bc691261a82b32bc"
  instance_type = "t2.micro"
  key_name = "eu-west-1-kp"
  subnet_id = "subnet-027995a49277edbed"
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]

  tags = {
    Name = "demo-tf-server-eu-west-1"
  }
}

resource "aws_instance" "ap_south_2" {
  provider = aws.hyderabad
  ami           = "ami-0bd4cda58efa33d23"
  instance_type = "t3.micro"
  key_name = null
  subnet_id = "subnet-069b1c4e3dfcc864e"
  vpc_security_group_ids = ["sg-068759665bacf3b9b"]

  tags = {
    Name = "demo-tf-server-ap-south-2"
  }
  
}