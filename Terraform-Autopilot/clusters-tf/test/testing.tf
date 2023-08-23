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
  default     = "us-central1-a"
}

resource "google_container_cluster" "gifs-website-cluster-test" {
  name               = "gifs-website-cluster-test"
  location           = var.zone
  initial_node_count = 1 
}

resource "google_container_node_pool" "test_node_pool" {
  name       = "test-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.test_cluster.name
  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 24
    disk_type    = "pd-standard"
  }
}

output "test_cluster_name" {
  value       = google_container_cluster.test_cluster.name
  description = "Test Cluster Name"
}

output "test_cluster_host" {
  value       = google_container_cluster.test_cluster.endpoint
  description = "Test Cluster IP"
}



