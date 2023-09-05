provider "google" {
  credentials = "/Users/daniel/Documents/DevOps/tkn/lofty-dynamics-393510-2b63cc077c5f.json"
  project     = "peak-surface-398109"
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "peak-surface-398109"
}

variable "zone" {
  description = "Cluster Zone"
  type        = string
  default     = "europe-west1"
} 

resource "google_container_cluster" "gifs-website-cluster-test" {
  name               = "gifs-website-cluster-test"
  location           = var.zone
  initial_node_count = 1 
  network            = "projects/peak-surface-398109/global/networks/gifs-website-test"
  subnetwork         = "projects/peak-surface-398109/regions/europe-west1/subnetworks/gifs-website-test"
}

resource "google_container_node_pool" "test_node_pool" {
  name       = "test-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.gifs-website-cluster-test.name
  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    machine_type = "e2-micro"
    disk_size_gb = 12
    disk_type    = "pd-standard"
  }
}







