output "private_vpc_id" {
  value = aws_subnet.Accuknox_private.id
}

output "security_group_id" {
  value = [aws_security_group.Accuknox_sg.id]
}