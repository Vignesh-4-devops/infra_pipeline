provider "aws" {
  profile = "vignesh"
  region  = var.region
}

module "vpc" {
  source = "./vpc"
  
  name            = var.name
  cidr            = var.vpc_cidr
  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs
}

module "eks_node_groups" {
  source           = "./eks"
  cluster_name     = var.name
  cluster_version  = var.k8s_version
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnets
  node_group_roles = var.node_group_roles
}
