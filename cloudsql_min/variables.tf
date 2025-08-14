variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Región donde se desplegará la instancia"
  type        = string
  default     = "us-central1"
}

variable "instance_name" {
  description = "Nombre de la instancia SQL"
  type        = string
  default     = "mi-sql-instance"
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "testdb"
}

variable "db_user" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Contraseña del usuario de la base de datos"
  type        = string
  sensitive   = true
}
