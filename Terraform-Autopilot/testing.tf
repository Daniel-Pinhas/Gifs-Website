provider "google" {
  project = "lofty-dynamics-393510"
  region  = "us-central1"
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


  node_pool {
    name           = "default-pool"
    initial_node_count = 1
    autoscaling {
      min_node_count = 1
      max_node_count = 3
    }
    management {
      auto_repair  = true
      auto_upgrade = true
    }

    machine_type = "e2-micro"
    
  }
}