module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "7.2.0"

  identifier = "usermgmt-db-dev"
  engine     = "postgres"
  engine_version = "15.4"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  name     = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  db_subnet_group_name   = module.vpc.database_subnet_group

  publicly_accessible = false
  multi_az            = false
  storage_encrypted   = true
  backup_retention_period = 7

  tags = var.tags
}