

# DB Subnet Group


resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "app-rds-subnet-group"
  description = "Subnet group for MySQL RDS instance"

  subnet_ids = var.subnet_ids

  tags = {
    Name        = "app-rds-subnet-group"
    Environment = "dev"
    Project     = "RDS-Automation"
  }
}



# Security Group


resource "aws_security_group" "rds_sg" {
  name        = "app-rds-sg"
  description = "Allow MySQL access from private network"
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL access from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "app-rds-sg"
    Environment = "dev"
    Project     = "RDS-Automation"
  }
}


# RDS MySQL Instance


resource "aws_db_instance" "mysql" {
  identifier = var.db_identifier

  engine         = "mysql"
  engine_version = "8.0"

  instance_class    = var.db_instance_class
  allocated_storage = var.allocated_storage
  storage_type      = "gp3"

  # Encryption
  storage_encrypted = true

  # Database Credentials
  db_name  = var.db_name
  username = local.db_credentials.username 
  password = local.db_credentials.password

  # Network Configuration
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false

  # High Availability
  multi_az = var.multi_az

  # Automated Backups
  backup_retention_period = var.backup_retention_period
  backup_window           = "03:00-04:00"

  # Maintenance Window
  maintenance_window = "sun:05:00-sun:06:00"

  # Development Settings
  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Name        = var.db_identifier
    Environment = "dev"
    Project     = "RDS-Automation"
  }
}
