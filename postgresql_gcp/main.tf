provider "google" {
  project = var.project_id
  region  = var.region
}

# Crea una instancia de Cloud SQL PostgreSQL
resource "google_sql_database_instance" "postgres_instance" {
  name             = var.instance_name
  region           = var.region
  database_version = "POSTGRES_15"        # Versión más reciente disponible

  settings {
    tier = "db-f1-micro"                  # Tipo de máquina más pequeña y barata
    availability_type = "ZONAL"

    backup_configuration {
      enabled = false                     # Desactivamos backups para simplicidad (no recomendado en prod)
    }

    ip_configuration {
      ipv4_enabled    = false             # Sin IP pública, solo red privada
      private_network = var.network       # Red privada VPC donde se conectará
    }

    disk_type = "PD_SSD"
    disk_size = 10                        # 10 GB de SSD
  }

  deletion_protection = false            # Permite destruir fácilmente
}

# Base de datos vacía inicial
resource "google_sql_database" "default_db" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres_instance.name
}

# Usuario de la DB
resource "google_sql_user" "default_user" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres_instance.name
  password = var.db_password
}
