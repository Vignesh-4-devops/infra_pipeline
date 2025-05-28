
output "kubeconfig" {
  description = "kubectl config file contents for this EKS cluster"
  value = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${module.eks_node_groups.cluster_endpoint}
    certificate-authority-data: ${module.eks_node_groups.cluster_certificate_authority_data}
  name: ${module.eks_node_groups.cluster_name}
contexts:
- context:
    cluster: ${module.eks_node_groups.cluster_name}
    user: ${module.eks_node_groups.cluster_name}
  name: ${module.eks_node_groups.cluster_name}
current-context: ${module.eks_node_groups.cluster_name}
kind: Config
preferences: {}
users:
- name: ${module.eks_node_groups.cluster_name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws
      args:
        - "eks"
        - "get-token"
        - "--cluster-name"
        - ${module.eks_node_groups.cluster_name}
KUBECONFIG
}