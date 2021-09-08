output "subnet_ids" {
  description = "Values for Subnet IDs to be used in other resources"
  value       = aws_subnet.subnet.id
}
