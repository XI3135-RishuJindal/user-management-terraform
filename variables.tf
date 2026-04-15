variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "user-mgmt-eks-dev"
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "usermgmt"
}

variable "db_username" {
  description = "PostgreSQL master username"
  type        = string
  default     = "usermgmtadmin"
}

variable "db_password" {
  description = "PostgreSQL master password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "user-management"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
    CostCenter  = "engineering"
  }
}