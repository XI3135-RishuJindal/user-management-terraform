module "msk" {
  source  = "terraform-aws-modules/msk-kafka-cluster/aws"
  version = "3.1.0"

  cluster_name           = "usermgmt-msk-dev"
  kafka_version          = "3.6.0"
  number_of_broker_nodes = 2

  broker_node_instance_type = "kafka.t3.small"
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  security_groups          = [module.vpc.default_security_group_id]

  encryption_in_transit = {
    client_broker = "TLS"
    in_cluster    = true
  }

  tags = var.tags
}