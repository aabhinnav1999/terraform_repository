variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "vpc_name" {
    description = "The name of the VPC"
    type        = string
}

variable "enable_dns_hostnames" {
    description = "Enable DNS hostnames in the VPC"
    type        = bool
    default     = false
}

variable "enable_dns_support" {
    description = "Enable DNS support in the VPC"
    type        = bool
    default     = true
}