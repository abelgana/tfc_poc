resource "google_cloudbuild_worker_pool" "private_pool" {
  name = "default-private-pool-local"

  project  = "svc-project-25e0"
  location = "us-east4"
  worker_config {
    disk_size_gb   = 100
    machine_type   = "e2-standard-4"
    no_external_ip = true
  }

  network_config {
    peered_network = "projects/host-project-013e/global/networks/shared-vpc"
  }
}
