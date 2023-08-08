provider "google" {
  project     = "lofty-dynamics-393510"
  region      = "us-central1"
  credentials = "/Users/daniel/Documents/DevOps/tkn/lofty-dynamics-393510-2b63cc077c5f.json"
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

locals {
  network_name = "lofty-dynamics-393510-vpc"
  subnet_name  = "lofty-dynamics-393510-subnet"
}

resource "google_compute_subnetwork" "subnet" {
  name          = local.subnet_name
  region        = "us-central1"
  network       = google_compute_network.vpc.self_link
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_container_cluster" "primary" {
  name             = "gifs-website-test"
  location         = "us-central1"
  network          = google_compute_network.vpc.id
  subnetwork       = google_compute_subnetwork.subnet.id
  enable_autopilot = true
}

resource "google_compute_firewall" "gifs_website_firewall" {
  name          = "gifs-website"
  network       = google_compute_network.vpc.self_link
  source_tags   = ["gifs-website-node"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80", "81", "82", "5000", "3306"]
  }
}