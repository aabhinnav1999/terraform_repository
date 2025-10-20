provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example" {

  # eu-west-1
  ami           = "ami-0bc691261a82b32bc"
  instance_type = "t3.medium"
  key_name = "eu-west-1-kp"
  subnet_id = "subnet-027995a49277edbed"
  vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]

  # us-east-1 
  # ami = "ami-0360c520857e3138f"
  # instance_type = "t2.micro"
  # key_name = null
  # subnet_id = "subnet-046bbbd58dad9e8f8"
  # vpc_security_group_ids = ["sg-05a37e2fb8b2a843b"]

  tags = {
    Name = "demo-tf-server"
  }
}


# randomly select an availability zone

# data "aws_availability_zones" "a_zones" {
#     state = "available"
# }

# resource "random_shuffle" "name" {
#     input        = data.aws_availability_zones.a_zones.names
#     result_count = 1
# }

# data "aws_subnets" "all" {
#   filter {
#     name   = "availability-zone"
#     values = [random_shuffle.name.result[0]]
#   }
# }

# resource "random_shuffle" "subnet" {
#   input        = data.aws_subnets.all.ids
#   result_count = 1
# }

# output "random_subnet_id" {
#   value = random_shuffle.subnet.result[0]
# }