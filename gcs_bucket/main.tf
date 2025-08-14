provider "google" {
  project = var.project_id         # ID del proyecto de GCP
  region  = var.region             # Región donde se usará el proveedor (aunque GCS es global)
}

resource "google_storage_bucket" "mi_bucket" {
  name     = var.bucket_name       # Nombre del bucket (único globalmente)
  location = var.location          # Ubicación del bucket: US, EU, etc.
  force_destroy = true             # Permite borrar el bucket aunque tenga archivos

  uniform_bucket_level_access = true  # Seguridad uniforme a nivel de bucket (recomendado)

  labels = {
    ambiente = "dev"               # Etiqueta opcional
  }
}