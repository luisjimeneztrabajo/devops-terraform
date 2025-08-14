output "vm_ip" {
  value       = google_compute_instance.vm_basica.network_interface[0].access_config[0].nat_ip
  description = "IP pública de la VM"
}