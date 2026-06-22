
resource "aws_ecr_repository" "app" {
  name                 = "2048-game"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  cluster_name = var.cluster_name
  region       = var.region
  az_1         = var.az_1
  az_2         = var.az_2
}


module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.cluster_name
  k8s_version      = var.k8s_version
  region           = var.region
  vpc_id           = module.vpc.vpc_id
  private_subnet_1 = module.vpc.private_subnet_ids[0]
  private_subnet_2 = module.vpc.private_subnet_ids[1]
  instance_type    = var.instance_type
  ami_type         = var.ami_type
  desired_size     = var.desired_size
  max_size         = var.max_size
  min_size         = var.min_size
}