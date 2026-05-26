resource "aws_vpc" "eks_proj_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_subnet" "public_eks_1" {
  vpc_id                  = aws_vpc.eks_proj_vpc.id
  cidr_block              = var.public_subnet_cidr_1
  availability_zone       = var.az_1
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "eks-public-subnet-1"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_eks_2" {
  vpc_id                  = aws_vpc.eks_proj_vpc.id
  cidr_block              = var.public_subnet_cidr_2
  availability_zone       = var.az_2
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "eks-public-subnet-2"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_eks_1" {
  vpc_id            = aws_vpc.eks_proj_vpc.id
  cidr_block        = var.private_subnet_cidr_1
  availability_zone = var.az_1

  tags = {
    Name                                        = "eks-private-subnet-1"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_eks_2" {
  vpc_id            = aws_vpc.eks_proj_vpc.id
  cidr_block        = var.private_subnet_cidr_2
  availability_zone = var.az_2

  tags = {
    Name                                        = "eks-private-subnet-2"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_proj_vpc.id

  tags = {
    Name = "eks-igw"
  }
}

resource "aws_eip" "nat" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.eks_igw]
}

resource "aws_nat_gateway" "eks_nat" {
  subnet_id     = aws_subnet.public_eks_1.id
  allocation_id = aws_eip.nat.id

  tags = {
    Name = "eks-nat"
  }

  depends_on = [aws_internet_gateway.eks_igw]
}

resource "aws_route_table" "eks_route_table_public" {
  vpc_id = aws_vpc.eks_proj_vpc.id

  route {
    cidr_block = var.all_traffic_cidr
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name = "eks-route-table-public"
  }
}

resource "aws_route_table" "eks_route_table_private" {
  vpc_id = aws_vpc.eks_proj_vpc.id

  route {
    cidr_block     = var.all_traffic_cidr
    nat_gateway_id = aws_nat_gateway.eks_nat.id
  }

  tags = {
    Name = "eks-route-table-private"
  }
}

resource "aws_route_table_association" "public_association_1" {
  subnet_id      = aws_subnet.public_eks_1.id
  route_table_id = aws_route_table.eks_route_table_public.id
}

resource "aws_route_table_association" "public_association_2" {
  subnet_id      = aws_subnet.public_eks_2.id
  route_table_id = aws_route_table.eks_route_table_public.id
}

resource "aws_route_table_association" "private_association_1" {
  subnet_id      = aws_subnet.private_eks_1.id
  route_table_id = aws_route_table.eks_route_table_private.id
}

resource "aws_route_table_association" "private_association_2" {
  subnet_id      = aws_subnet.private_eks_2.id
  route_table_id = aws_route_table.eks_route_table_private.id
}

resource "aws_security_group" "eks_sg" {
  name        = "eks-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.eks_proj_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.eks_sg.id
  cidr_ipv4         = var.all_traffic_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.eks_sg.id
  cidr_ipv4         = var.all_traffic_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.eks_sg.id
  cidr_ipv4         = var.all_traffic_cidr
  ip_protocol       = "-1"
}