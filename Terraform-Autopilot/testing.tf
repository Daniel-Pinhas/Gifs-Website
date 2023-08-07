provider "google" {
  project = "lofty-dynamics-393510"
  region  = "us-central1"
  credentials = "/Users/daniel/Documents/DevOps/tkn/lofty-dynamics-393510-2b63cc077c5f.json"
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
  

