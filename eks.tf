module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.18.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnets

  enable_irsa = true

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 1

      instance_types = ["t3.medium"]
      subnets       = module.vpc.public_subnets
      tags          = var.tags
    }
  }

  tags = var.tags
}