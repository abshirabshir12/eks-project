terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.41.0"
    }
  }

  backend "s3" {
    bucket       = "eks-proj-abs"
    key          = "terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "eu-north-1"
}
