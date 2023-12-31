output "subnets" {
  value = aws_subnet.this[*].id
}
