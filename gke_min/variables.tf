variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Región para la red; el cluster será zonal dentro de esta región"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona del cluster (zonal)"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "Nombre del cluster"
  type        = string
  default     = "gke-min"
}

variable "network_name" {
  description = "Nombre de la VPC"
  type        = string
  default     = "vpc-gke-min"
}

variable "subnetwork_name" {
  description = "Nombre de la subred"
  type        = string
  default     = "subnet-gke-min"
}

variable "subnetwork_cidr" {
  description = "CIDR de la subred principal"
  type        = string
  default     = "10.0.0.0/16"
}

variable "pods_secondary_cidr" {
  description = "CIDR secundario para Pods"
  type        = string
  default     = "10.1.0.0/16"
}

variable "services_secondary_cidr" {
  description = "CIDR secundario para Services"
  type        = string
  default     = "10.2.0.0/20"
}

variable "node_count" {
  description = "Número de nodos del node pool"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Tipo de máquina para los nodos"
  type        = string
  # e2-medium es un mínimo seguro en GKE; si tu región admite e2-small, puedes bajarlo.
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "Tamaño de disco de cada nodo"
  type        = number
  default     = 50
}

variable "release_channel" {
  description = "Canal de release del cluster (RAPID, REGULAR, STABLE)"
  type        = string
  default     = "REGULAR"
}