variable "cluster_name" {
  description = "The name of the EKS cluster."
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster."
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be deployed."
}

variable "node_group_roles" {
  description = "List of IAM policy ARNs to attach to node group roles."
  type        = list(string)
}

variable "node_groups" {
  description = "Map of EKS managed node group configurations"
  type = map(object({
    desired_size    = number
    max_size        = number
    min_size        = number
    instance_types  = list(string)
    ami_type        = string
  }))
  default = {
    default = {
      desired_size   = 2
      max_size       = 3
      min_size       = 2
      instance_types = ["t3.medium"]
      ami_type       = "AL2023_x86_64_STANDARD"
    }
  }
}
