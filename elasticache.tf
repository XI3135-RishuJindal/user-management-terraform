module "redis" {
  source  = "terraform-aws-modules/elasticache/aws"
  version = "1.11.0"

  name                 = "usermgmt-redis-dev"
  engine               = "redis"
  engine_version       = "7.0"
  node_type            = "cache.t3.micro"
  number_cache_clusters = 1

  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.public_subnets
  security_group_ids   = [module.vpc.default_security_group_id]

  apply_immediately    = true
  automatic_failover_enabled = false

  tags = var.tags
}