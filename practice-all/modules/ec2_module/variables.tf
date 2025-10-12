variable "ami_id" {
    description = "The AMI ID for the EC2 instance"
    type        = string
    default     = "ami-0bc691261a82b32bc"
}

variable "instance_type" {
    description = "The type of EC2 instance"
    type        = string
    default     = "t2.micro"
}

variable "Name" {
    description = "The Name tag for the EC2 instance"
    type        = string
    default     = "ExampleInstance"
}

variable "subnet_id" {
    description = "The Subnet ID for the EC2 instance"
    type        = string
}

variable "security_groups" {
    description = "The Security Groups for the EC2 instance"
    type        = list(string)
}

variable "key_name" {
    description = "The Key Pair name for the EC2 instance"
    type        = string
}