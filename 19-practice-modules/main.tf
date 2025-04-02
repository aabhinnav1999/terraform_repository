provider "aws" {
    region = "eu-west-1"
}

# module "my-ec2-instance" {

#     source = "./modules/ec2"
#     ami_value = "ami-03cc8375791cb8bcf"
#     instance_type_value = "t3.micro"
#     instance_name = "terraform-instance"
#     key_pair_name = "irl-keypair"
#     security_group_value = ["sg-013ef36435de1738d"]
#     disable_termination = true
#     monitoring = true
# }

# module "my-ec2-instance-2" {
    
#     source = "./modules/ec2"
#     ami_value = "ami-03cc8375791cb8bcf"
#     instance_type_value = "t3.micro"
#     instance_name = "terraform-instance-2"
#     key_pair_name = "irl-keypair"
#     security_group_value = ["sg-013ef36435de1738d"]
#     availability_zone = "eu-west-1c"
# }

module "my-asg-lt" {
    source = "./modules/asg_lt"
    name = "my-demo-asg"
    availability_zones = [ "eu-west-1a","eu-west-1b","eu-west-1c" ]
    max_size = 6
    min_size = 1
    desired_capacity = 2
    key_pair_name = "irl-keypair"
    lt_name = "my-demo-lt"
    instance_type_value = "t2.micro"
    ami_value = "ami-03cc8375791cb8bcf"
    security_group_value = [ "sg-013ef36435de1738d" ]
    target_group_arns_value = [ "arn:aws:elasticloadbalancing:eu-west-1:233538284395:targetgroup/my-demo-tg/8d4d4a3645f66b10" ]
}

module "my-elb-tg" {
    source = "./modules/elb_tg"
}
