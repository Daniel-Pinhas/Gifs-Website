provider "google" {
  credentials = "/Users/daniel/Documents/DevOps/tkn/lofty-dynamics-393510-2b63cc077c5f.json"
  project     = "lofty-dynamics-393510"
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "lofty-dynamics-393510"
}

variable "zone" {
  description = "Cluster Zone"
  type        = string
  default     = "europe-west1"
} 

resource "google_container_cluster" "gifs-website-cluster-prod" {
  name               = "gifs-website-cluster-prod"
  location           = var.zone
  initial_node_count = 1 
  network            = "projects/lofty-dynamics-393510/global/networks/gifs-website-prod"
  subnetwork         = "projects/lofty-dynamics-393510/regions/europe-west1/subnetworks/gifs-website-prod"
}

resource "google_container_node_pool" "test_node_pool" {
  name       = "test-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.gifs-website-cluster-prod.name
  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 24
    disk_type    = "pd-standard"
  }
}





