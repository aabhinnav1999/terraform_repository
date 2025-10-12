module "ec2_instance" {
    source =  "git::https://github.com/aabhinnav1999/terraform_repository.git//practice-all/modules/ec2_module"
    ami_id = "ami-0bc691261a82b32bc"
    instance_type = "t2.micro"
    Name = "DemoInstance"
    subnet_id = "subnet-08fd5ca933492eef7"
    key_name = "eu-west-1-kp"
    security_groups = ["sg-0cb9fa18187a0b901"]
}