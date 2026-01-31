# 1. VPC
resource "google_compute_network" "vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

# 2. Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc.id
}

# 3. Service Account
resource "google_service_account" "sa" {
  account_id   = "terraform-sa"
  display_name = "Terraform Service Account"
}

# 4. IAM Role Binding
resource "google_project_iam_member" "sa_editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

# 5. Artifact Registry
resource "google_artifact_registry_repository" "repo" {
  provider = google
  location = var.region
  repository_id = "my-repo"
  format = "DOCKER"
}

# 6. GCS Bucket for Terraform Remote State
resource "google_storage_bucket" "tf_state" {
  name          = var.tf_state_bucket
  location      = var.region
  force_destroy = true
}

# 7. GKE Cluster
resource "google_container_cluster" "gke_cluster" {
  name     = var.gke_cluster_name
  location = var.zone

  network    = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.subnet.id

  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

# 8. Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = google_container_cluster.gke_cluster.location
  node_count = 2

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}