# GCP Project ID
variable "project_id" {
  type        = string
  description = "The GCP project ID where resources will be created."
}

# GCP region
variable "region" {
  type        = string
  description = "The GCP region for regional resources (VPC, subnet, buckets, Artifact Registry)."
  default     = "us-central1"
}

# GCP zone
variable "zone" {
  type        = string
  description = "The GCP zone for zonal resources (GKE cluster, node pool)."
  default     = "us-central1-a"
}

# Terraform remote state bucket
variable "tf_state_bucket" {
  type        = string
  description = "The name of the GCS bucket used to store Terraform remote state."
}

# GKE cluster name
variable "gke_cluster_name" {
  type        = string
  description = "The name of the GKE cluster."
  default     = "my-gke-cluster"
}

# VPC name
variable "vpc_name" {
  type        = string
  description = "The name of the VPC network."
  default     = "my-vpc"
}

# Subnet name
variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
  default     = "my-subnet"
}

# Subnet CIDR range
variable "subnet_cidr" {
  type        = string
  description = "The IP CIDR range for the subnet."
  default     = "10.0.0.0/16"
}

# Service account ID
variable "service_account_id" {
  type        = string
  description = "The ID for the Terraform service account."
  default     = "terraform-sa"
}

# Artifact Registry repository ID
variable "artifact_registry_repo_id" {
  type        = string
  description = "The Artifact Registry repository ID."
  default     = "my-repo"
}

# Node pool machine type
variable "node_machine_type" {
  type        = string
  description = "The machine type for GKE cluster nodes."
  default     = "e2-medium"
}

# Node pool size
variable "node_count" {
  type        = number
  description = "The number of nodes in the GKE node pool."
  default     = 2
}

# Node pool preemptible setting
variable "node_preemptible" {
  type        = bool
  description = "Whether GKE nodes are preemptible (cheaper, short-lived)."
  default     = false
}
