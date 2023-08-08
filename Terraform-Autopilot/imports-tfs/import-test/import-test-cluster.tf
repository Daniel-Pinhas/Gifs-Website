import {
  to = google_container_cluster.primary
  id = "projects/lofty-dynamics-393510/locations/us-central1/clusters/gifs-website-test"
}

resource "google_container_cluster" "primary" {
  name             = "gifs-website-test"
  location         = "us-central1"
  network          = google_compute_network.vpc.name
  subnetwork       = google_compute_subnetwork.subnet.name
  enable_autopilot = true
}

import {
  to = google_compute_network.vpc
  id = "projects/lofty-dynamics-393510/global/networks/lofty-dynamics-393510-vpc"
}

import {
  to = google_compute_subnetwork.subnet
  id = "projects/lofty-dynamics-393510/regions/us-central1/subnetworks/lofty-dynamics-393510-subnet"
}

provider "google" {
  credentials = "/Users/daniel/Documents/DevOps/tkn/lofty-dynamics-393510-2b63cc077c5f.json"
  project     = "lofty-dynamics-393510"
  region      = "us-central1"
}


locals {
  network_name = "gifs-website-test-vpc"
  subnet_name  = "gifs-website-test-subnet"
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

import {
  to = google_compute_firewall.gifs_website_firewall
  id = "gifs-website-test"
}
