
# AWS Configuration


variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


# VPC Configuration


variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0134ccdad00bf65cc"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}


# RDS Subnets


variable "subnet_ids" {
  description = "Private subnet IDs for RDS"
  type        = list(string)

  default = [
     "subnet-0e1232c535cfcde72",
    "subnet-060b9a8694e8b56c1"
  ]
}



# RDS Configuration


variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
  default     = "app-mysql-db"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
  default     = "Password123!"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}