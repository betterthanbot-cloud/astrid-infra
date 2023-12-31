resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.this.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids             = var.vpc_subnet_ids
    endpoint_public_access = var.endpoint_public_access
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
  tags = merge(
    local.tags,
    {
      Name = join("-", ["aws-eks-cluster", var.cluster_name])
  })
}
