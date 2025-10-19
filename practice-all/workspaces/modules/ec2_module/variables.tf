variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
}

variable "ami_id" {
    description = "The AMI ID for the EC2 instance"
    type        = string
}

variable "instance_type" {
    description = "The type of instance to use"
    type        = string
}

variable "subnet_id" {
    description = "The subnet ID to launch the instance in"
    type        = string
}

variable "key_name" {
    description = "The name of the key pair to use for SSH access"
    type        = string
}

variable "vpc_security_group_ids" {
    description = "A list of VPC security group IDs to associate with"
    type        = set(string)
}

variable "tags" {
    description = "A map of tags to assign to the instance"
    type        = map(string)
}