variable "max_size" {
    description = "enter the maximum number of instances"
    type = number
}

variable "min_size" {
    description = "enter the minimum number of instances"
    type = number
}

variable "desired_capacity" {
    description = "enter the desired capacity"
    type = number
}

variable "availability_zones" {
    description = "enter availabilty zones here"
    type = list(string)
}

variable "name" {
    description = "name for the auto scaling groups"
    type = string     
}

variable "lt_name" {
    description = "name for the launch template"
    type = string
}

variable "ami_value" {
    description = "write ami value here"
    type = string
}

variable "instance_type_value" {
    description = "write instance type here"
    type = string
}

variable "key_pair_name" {
    description = "write key pair name here"
    default = ""
    type = string
}

variable "security_group_value" {
    description = "write security group here"
    type = list(string)
}

variable "lt_tags" {
    description = "tags for the launch template"
    type = string
    default = null
}

variable "target_group_arns_value" {
    description = "give alb target_group_arns or nlb target_group_arns"
    default = [ "" ]
    type = list(string)
}