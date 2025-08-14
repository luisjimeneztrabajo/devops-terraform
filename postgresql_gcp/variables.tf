variable "project_id" {
  type        = string
  description = "ID del proyecto de GCP"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Región para la instancia"
}

variable "instance_name" {
  type        = string
  description = "Nombre de la instancia de Cloud SQL"
}

variable "db_name" {
  type        = string
  description = "Nombre de la base de datos"
}

variable "db_user" {
  type        = string
  description = "Nombre de usuario de la base de datos"
}

variable "db_password" {
  type        = string
  description = "Contraseña del usuario (considera encriptarla en Vault o secrets manager)"
  sensitive   = true
}

variable "network" {
  type        = string
  description = "Self-link de la red VPC (debe existir previamente)"
}
