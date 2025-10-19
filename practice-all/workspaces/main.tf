variable "instance_type" {
    description = "Type of the EC2 instance"
    type        = map(string)

    default = {
      "dev" = "t2.micro"
       "qa"     = "t3.small"
        "prod"  = "t3.medium"
    }
}

module "ec2_instance" {
    source       = "./modules/ec2_module"
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
    ami_id        = "ami-0bc691261a82b32bc"
    aws_region    = "eu-west-1"
    subnet_id     = "subnet-08fd5ca933492eef7"
    key_name      = "eu-west-1-kp"
    vpc_security_group_ids = ["sg-0cb9fa18187a0b901"]
    tags = {
        Name = "DemoInstance-${terraform.workspace}"
        environment = terraform.workspace
    }
}

output "instance_id" {
    value = module.ec2_instance.instance_id
}
