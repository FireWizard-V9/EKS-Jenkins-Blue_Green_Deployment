output "public_ips" {
  value = aws_instance.bg_instances[*].public_ip
}

