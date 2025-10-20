provider "aws" {
    region = "eu-west-1"
}

# import {
#     id   = "i-051f1a63f93f0b0bd"
#     to = aws_instance.server_1
# }

resource "aws_instance" "server_1" {
  ami                                  = "ami-0bc691261a82b32bc"
  subnet_id                            = "subnet-0e2604974ab1b723a"
  key_name                             = "eu-west-1-kp"
  vpc_security_group_ids      = ["sg-0cb9fa18187a0b901"]
  instance_type                        = "t2.nano"

  tags = {
    Name = "my-web-server"
  }

#   associate_public_ip_address          = true
#   availability_zone                    = "eu-west-1a"
#   disable_api_stop                     = false
#   disable_api_termination              = false
#   ebs_optimized                        = false
# #   enable_primary_ipv6                  = null
#   force_destroy                        = false
#   get_password_data                    = false
#   hibernation                          = false
#   host_id                              = null
#   host_resource_group_arn              = null
#   iam_instance_profile                 = null
#   instance_initiated_shutdown_behavior = "stop"
# #   ipv6_address_count                   = 0
# #   ipv6_addresses                       = []
#   monitoring                           = false
#   placement_group                      = null
#   placement_group_id                   = null
#   placement_partition_number           = 0
#   private_ip                           = "172.31.0.216"
#   region                               = "eu-west-1"
#   secondary_private_ips                = []
#   security_groups                      = ["my-sg"]
#   source_dest_check                    = true
  
#   tags_all = {
#     Name = "server-1"
#   }
#   tenancy                     = "default"
#   user_data                   = null
#   user_data_base64            = null
#   user_data_replace_on_change = null
#   volume_tags                 = null
#   capacity_reservation_specification {
#     capacity_reservation_preference = "open"
#   }
#   cpu_options {
#     amd_sev_snp      = null
#     core_count       = 1
#     threads_per_core = 1
#   }
#   credit_specification {
#     cpu_credits = "standard"
#   }
#   enclave_options {
#     enabled = false
#   }
#   maintenance_options {
#     auto_recovery = "default"
#   }
#   metadata_options {
#     http_endpoint               = "enabled"
#     http_protocol_ipv6          = "disabled"
#     http_put_response_hop_limit = 2
#     http_tokens                 = "required"
#     instance_metadata_tags      = "disabled"
#   }
# #   primary_network_interface {
# #     network_interface_id = "eni-0c7aa38fb2fbef822"
# #   }
#   private_dns_name_options {
#     enable_resource_name_dns_a_record    = false
#     enable_resource_name_dns_aaaa_record = false
#     hostname_type                        = "ip-name"
#   }
#   root_block_device {
#     delete_on_termination = true
#     encrypted             = false
#     iops                  = 3000
#     kms_key_id            = null
#     tags                  = {}
#     tags_all              = {}
#     throughput            = 125
#     volume_size           = 8
#     volume_type           = "gp3"
#   }

}