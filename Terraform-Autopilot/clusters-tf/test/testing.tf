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

resource "google_container_cluster" "gifs-website-cluster-test" {
  name               = "gifs-website-cluster-test"
  location           = var.zone
  initial_node_count = 1 
  network            = "projects/lofty-dynamics-393510/global/networks/gifs-website-test"
  subnetwork         = "projects/lofty-dynamics-393510/regions/europe-west1/subnetworks/gifs-website-test"
}

resource "google_container_node_pool" "test_node_pool" {
  name       = "test-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.gifs-website-cluster-test.name
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
  value       = google_container_cluster.gifs-website-cluster-test.name
  description = "Test Cluster Name"
}

output "test_cluster_host" {
  value       = google_container_cluster.gifs-website-cluster-test.endpoint
  description = "Test Cluster IP"
}


    app.kubernetes.io/managed-by: Helm
    meta.helm.sh/release-name: {{ .Release.Name }}
    meta.helm.sh/release-namespace: {{ .Release.Namespace }}


    apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: flask-ingress
  labels:
spec:
  rules:
    - http:
        paths:
          - path: /flask-1
            pathType: Prefix
            backend:
              service:
                name: flask-service-1
                port:
                  number: 80
          - path: /flask-2
            pathType: Prefix
            backend:
              service:
                name: flask-service-2
                port:
                  number: 80
          - path: /flask-3
            pathType: Prefix
            backend:
              service:
                name: flask-service-3
                port:
                  number: 80
