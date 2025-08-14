variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  description = "Región de GCP (no afecta GCS, pero requerido por el provider)"
  type        = string
  default     = "us-central1"
}

variable "location" {
  description = "Ubicación del bucket"
  type        = string
  default     = "US"
}

variable "bucket_name" {
  description = "Nombre único del bucket"
  type        = string
}