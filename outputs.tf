
# RDS Outputs


output "db_name" {
  description = "RDS database name"
  value       = aws_db_instance.mysql.db_name
}

output "db_port" {
  description = "RDS MySQL port"
  value       = aws_db_instance.mysql.port
}