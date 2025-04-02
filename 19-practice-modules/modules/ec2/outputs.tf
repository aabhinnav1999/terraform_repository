output "ip-address" {
    value = aws_instance.demo-instance.public_ip
}