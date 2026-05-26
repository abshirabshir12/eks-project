output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.eks_proj_vpc.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_eks_1.id, aws_subnet.public_eks_2.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private_eks_1.id, aws_subnet.private_eks_2.id]
}

output "security_group_id" {
  description = "The ID of the EKS security group"
  value       = aws_security_group.eks_sg.id
}

