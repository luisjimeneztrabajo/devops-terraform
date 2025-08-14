provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "vm_basica" {
  name         = var.instance_name
  machine_type = "e2-micro"                  # Tipo de máquina más simple
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"       # Imagen base (puedes cambiar a ubuntu)
      size  = 10                              # Disco de 10 GB
      type  = "pd-standard"                  # Disco estándar
    }
  }

  network_interface {
    network       = "default"                # Red por defecto
    access_config {}                         # Asigna IP pública (necesario si quieres acceso SSH)
  }

  tags = ["vm-básica"]

  metadata = {
    startup-script = "echo Hola desde la VM > /var/tmp/saludo.txt"
  }
}
