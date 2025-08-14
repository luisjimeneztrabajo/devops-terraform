terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

# Habilita APIs mínimas (Compute y GKE) para evitar fallas de primera vez
resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  project = var.project_id
  service = "container.googleapis.com"
  depends_on = [google_project_service.compute]
}

# Red y subred con rangos secundarios (VPC-native requerido por GKE moderno)
resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  depends_on              = [google_project_service.compute]
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnetwork_name
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.subnetwork_cidr

  secondary_ip_range {
    range_name    = "${var.subnetwork_name}-pods"
    ip_cidr_range = var.pods_secondary_cidr
  }

  secondary_ip_range {
    range_name    = "${var.subnetwork_name}-services"
    ip_cidr_range = var.services_secondary_cidr
  }
}

# Cluster GKE (zonal), sin node pool por defecto
resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.zone

  network    = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link

  # VPC-native con rangos secundarios
  ip_allocation_policy {
    cluster_secondary_range_name  = "${var.subnetwork_name}-pods"
    services_secondary_range_name = "${var.subnetwork_name}-services"
  }

  # Elimina el default node pool (crearemos uno gestionado aparte)
  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = var.release_channel
  }

  # Logging/Monitoring mínimos
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  depends_on = [
    google_project_service.container,
    google_compute_subnetwork.subnet
  ]
}

# Node Pool con 3 nodos
resource "google_container_node_pool" "pool" {
  name       = "${var.cluster_name}-pool"
  project    = var.project_id
  location   = var.zone
  cluster    = google_container_cluster.cluster.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    image_type   = "COS_CONTAINERD"

    # Scopes amplios para simplificar el demo (ajusta a mínimos en prod)
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    # Habilitar metadata conceal para seguridad básica
    metadata = {
      disable-legacy-endpoints = "true"
    }

    # Etiquetas simples
    labels = {
      env  = "dev"
      app  = var.cluster_name
    }

    tags = ["gke", var.cluster_name]
  }

  # Estrategia de actualización simple
  management {
    auto_upgrade = true
    auto_repair  = true
  }

  depends_on = [google_container_cluster.cluster]
}