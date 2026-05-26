variable "k8s_version" {
  description = "Version of Kubernetes for the EKS cluster"
  type        = string
  default     = "1.29"
}

variable "private_subnet_1" {
  description = "ID of the first private subnet"
  type        = string
}

variable "private_subnet_2" {
  description = "ID of the second private subnet"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC for the cluster"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the node groups"
  type        = string
  default     = "t3.medium"
}

variable "ami_type" {
  description = "AMI type for the node groups"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-north-1"
}