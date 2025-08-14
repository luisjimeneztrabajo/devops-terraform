output "cluster_name" {
  value = google_container_cluster.cluster.name
}

output "location" {
  value = google_container_cluster.cluster.location
}

output "endpoint" {
  value = google_container_cluster.cluster.endpoint
}

output "ca_certificate" {
  value     = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
  sensitive = true
}

output "network" {
  value = google_compute_network.vpc.name
}

output "subnetwork" {
  value = google_compute_subnetwork.subnet.name
}