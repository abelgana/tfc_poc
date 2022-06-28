output "instance_name" {
  value       = module.sql-db.instance_name
  description = "The instance name for the master instance"
}

output "public_ip_address" {
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance"
  value       = module.sql-db.public_ip_address
}

output "private_ip_address" {
  description = "The first private (PRIVATE) IPv4 address assigned for the master instance"
  value       = module.sql-db.private_ip_address
}

output "instance_ip_address" {
  value       = module.sql-db.instance_ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "instance_first_ip_address" {
  value       = module.sql-db.instance_first_ip_address
  description = "The first IPv4 address of the addresses assigned."
}

output "instance_connection_name" {
  value       = module.sql-db.instance_connection_name
  description = "The connection name of the master instance to be used in connection strings"
}

output "instance_self_link" {
  value       = module.sql-db.instance_self_link
  description = "The URI of the master instance"
}

output "instance_server_ca_cert" {
  value       = module.sql-db.instance_server_ca_cert
  description = "The CA certificate information used to connect to the SQL instance via SSL"
}

output "instance_service_account_email_address" {
  value       = module.sql-db.instance_service_account_email_address
  description = "The service account email address assigned to the master instance"
}

// Resources
output "primary" {
  value       = module.sql-db.primary
  description = "The `google_sql_database_instance` resource representing the primary instance"
  sensitive   = true
}
