output "vpc_id" {
  value = aws_vpc.Ease-VPC.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.Ease-PUB-SUBNET-1a.id,
    aws_subnet.Ease-PUB-SUBNET-1b.id
  ]
}

output "security_group_id" {
  value = aws_security_group.Ease-Security-Group.id
}