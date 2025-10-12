output "instance-public-ip" {
    description = "The public IP address of the EC2 instance"
    value       = aws_instance.demo_instance.public_ip
}