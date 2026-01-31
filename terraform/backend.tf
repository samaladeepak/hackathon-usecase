terraform {
  backend "gcs" {
    bucket      = var.tf_state_bucket   # GCS bucket name for remote state
    prefix      = "terraform/state"     # Path inside the bucket to store state
    location    = var.region           # GCP region of the bucket
    credentials = var.gcp_credentials_file # Optional: path to service account JSON
  }
}
