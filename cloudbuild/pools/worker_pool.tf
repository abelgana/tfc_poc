resource "google_cloudbuild_worker_pool" "private_pool" {
  name = var.name

  project  = data.tfe_outputs.foundation.values.svc_project_id
  location = var.region
  worker_config {
    disk_size_gb   = 100
    machine_type   = "e2-standard-4"
    no_external_ip = true
  }

  network_config {
    peered_network = data.tfe_outputs.foundation.values.vpc_id
  }
}
