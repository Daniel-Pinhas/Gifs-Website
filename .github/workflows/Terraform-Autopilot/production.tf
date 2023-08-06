provider "google" {
  project = "lofty-dynamics-393510"
  region  = "us-central1"
}

terraform {
    backend "gcs" {
        bucket = "gifs-website-bucket"
        prefix = "terraform/state"
  }
}