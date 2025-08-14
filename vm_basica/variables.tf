variable "project_id" {
  type        = string
  description = "ID del proyecto GCP"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Región para la instancia"
}

variable "zone" {
  type        = string
  default     = "us-central1-a"
  description = "Zona dentro de la región"
}

variable "instance_name" {
  type        = string
  description = "Nombre de la instancia"
}