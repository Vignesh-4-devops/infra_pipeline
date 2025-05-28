module "eks_node_groups" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version 
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id
  
  eks_managed_node_groups = {
    for name, config in var.node_groups : name => {
      desired_size    = config.desired_size
      max_size        = config.max_size
      min_size        = config.min_size
      instance_types  = config.instance_types
      ami_type        = config.ami_type

      iam_role_additional_policies = {
        for policy in var.node_group_roles : policy => policy
      }
    }
  }

  enable_irsa = true
   # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true
}
