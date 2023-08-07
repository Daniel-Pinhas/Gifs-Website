provider "google" {
  credentials = ""
  project = "lofty-dynamics-393510"
  region  = "us-central1"
}

terraform {
    backend "gcs" {
        bucket = "gifs-website-bucket"
        prefix = "terraform/state"
  }
}

resource "google_compute_network" "vpc" {
  name                    = local.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = local.subnet_name
  region        = "us-central1"
  network       = google_compute_network.vpc.self_link
  ip_cidr_range = "10.10.0.0/24"
}