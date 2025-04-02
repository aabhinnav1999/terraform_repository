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

variable "instance_name" {
    description = "write instance name here"
    default = ""
    type = string
}

variable "availability_zone" {
    description = "value for availabilty zone, default is eu-west-1a"
    default = "eu-west-1a"
    type = string
}

variable "disable_stop" {  
    description = "use for instance stop protection" 
    default =  false
    type = bool
}

variable "disable_termination" {
    description = "use for instance termination protection"
    default =  false
    type = bool
}

variable "monitoring" {
    description = "value for monitoring, default is false"
    default = false
    type = bool
}