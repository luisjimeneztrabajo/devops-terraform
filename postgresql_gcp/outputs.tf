output "instance_connection_name" {
  value       = google_sql_database_instance.postgres_instance.connection_name
  description = "Connection string para conectarse vía Cloud SQL Proxy"
}
