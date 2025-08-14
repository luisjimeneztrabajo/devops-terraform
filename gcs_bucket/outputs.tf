output "bucket_url" {
  value       = "gs://${google_storage_bucket.mi_bucket.name}"
  description = "URL del bucket creado"
}
