output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.eks_proj_cluster.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint URL of the EKS cluster"
  value       = aws_eks_cluster.eks_proj_cluster.endpoint
}

output "eks_cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "ARN of the EKS node group IAM role"
  value       = aws_iam_role.eks_node_role.arn
}

output "eks_node_group_id" {
  description = "ID of the EKS node group"
  value       = aws_eks_node_group.eks_node_group.id
}

output "cert_manager_role_arn" {
  description = "ARN of the CertManager IAM role"
  value       = aws_iam_role.cert_manager_role.arn
}

output "external_dns_role_arn" {
  description = "ARN of the ExternalDNS IAM role"
  value       = aws_iam_role.external_dns_role.arn
}

output "external_dns_policy_arn" {
  description = "ARN of the ExternalDNS Route53 IAM policy"
  value       = aws_iam_policy.external_dns_policy.arn
}