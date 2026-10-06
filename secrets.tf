
# Secrets Manager for RDS Credentials


data "aws_secretsmanager_secret" "db" {
  name = var.db_secret_name
}

data "aws_secretsmanager_secret_version" "db" {
  secret_id = data.aws_secretsmanager_secret.db.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)
}
