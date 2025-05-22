
output "public_subnet_id" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public_subnet[*].id
}

# output "public_subnet_azs" {
#   value = [for s in aws_subnet.public_subnets : s.availability_zone]
# }

output "public_subnet_azs" {
  value = aws_subnet.public_subnet[*].availability_zone
}


output "private_subnet_id" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private_subnet[*].id
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.elb_vpc.id
}

output "azs" {
  value = data.aws_availability_zones.available_zones.names
}
