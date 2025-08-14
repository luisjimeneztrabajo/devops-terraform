provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_sql_database_instance" "default" {
  name             = var.instance_name
  region           = var.region
  database_version = "POSTGRES_13"

  settings {
    tier = "db-f1-micro" # Instancia más pequeña
    ip_configuration {
      ipv4_enabled    = true
      authorized_networks {
        name  = "allow-all"
        value = "0.0.0.0/0" # ⚠️ acceso abierto (para pruebas)
      }
    }
  }

  deletion_protection = false
}

resource "google_sql_user" "default" {
  name     = var.db_user
  instance = google_sql_database_instance.default.name
  password = var.db_password
}

resource "google_sql_database" "default" {
  name     = var.db_name
  instance = google_sql_database_instance.default.name
}
