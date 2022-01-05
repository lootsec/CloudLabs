output "public_dns" {
  description = "Public DNS names assigned to the instances."
  value       = aws_instance.prod-server.*.public_dns
}

output "public_ip" {
  description = "Public IP addresses assigned to the instances"
  value       = aws_instance.prod-server.*.public_ip
}

output "key_name" {
  description = "SSH key for the user ec2-user"
  value       = aws_instance.prod-server.*.key_name
}