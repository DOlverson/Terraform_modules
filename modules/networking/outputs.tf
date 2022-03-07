output "instance_subnet" {
  value = aws_subnet.public_subnet.id
}

output "instance_sg" {
  value = aws_security_group.ssh_access.id
}