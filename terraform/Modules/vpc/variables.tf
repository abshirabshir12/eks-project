variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "region" {
  description = "region"
  type = string
  default = "eu-north-1"
}

variable "cluster_name" {
  description = "name of eks cluster"
  type        = string
  default     = "eks-proj"
}
variable "az_1" {
 description = "availability zones"
  type = string
  default = "eu-north-1a"
}

variable "az_2" {
  description = "availability zones"
  type = string
  default = "eu-north-1b"
}

variable "public_subnet_cidr_1" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_1" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}

variable "all_traffic_cidr" {
  type = string
  default = "0.0.0.0/0"
}