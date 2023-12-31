resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = join("-", ["eks-node-group", var.cluster_name])
  node_role_arn   = aws_iam_role.node_group_iam_role.arn
  subnet_ids      = var.vpc_subnet_ids
  instance_types  = ["t3.medium"]

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  depends_on = [
    aws_iam_role.node_group_iam_role,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = merge(
    local.tags,
    {
      Name = join("-", ["eks-node-group", var.cluster_name])
  })
}
