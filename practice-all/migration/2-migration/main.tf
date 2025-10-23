provider "aws" {
    region = "eu-west-1"
}

# import {
#     id  = "i-0775fa2cec088391b"
#     to = aws_instance.example_1
# }

resource "aws_instance" "example_1" {
  ami                                  = "ami-033a3fad07a25c231"
  associate_public_ip_address          = true
  availability_zone                    = "eu-west-1c"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
#   enable_primary_ipv6                  = null
  force_destroy                        = false
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = null
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
#   ipv6_address_count                   = 0
#   ipv6_addresses                       = []
  key_name                             = "webserver-kp"
  monitoring                           = false
  placement_group                      = null
  placement_group_id                   = null
  placement_partition_number           = 0
  private_ip                           = "172.31.46.128"
  region                               = "eu-west-1"
  secondary_private_ips                = []
  security_groups                      = ["default"]
  source_dest_check                    = true
  subnet_id                            = "subnet-027995a49277edbed"
  tags = {
    Name = "my-server"
  }
  tags_all = {
    Name = "my-server"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-081c14c66590eb780"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 1
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    # http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
#   primary_network_interface {
#     network_interface_id = "eni-0629727429ede704d"
#   }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    kms_key_id            = null
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 8
    volume_type           = "gp3"
  }
}