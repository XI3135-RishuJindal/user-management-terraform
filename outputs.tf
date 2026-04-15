output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "redis_endpoint" {
  value = module.redis.primary_endpoint_address
}

output "msk_bootstrap_brokers" {
  value = module.msk.bootstrap_brokers_tls
}

output "eks_kubeconfig" {
  value = module.eks.kubeconfig
  sensitive = true
}