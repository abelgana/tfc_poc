resource "google_cloudbuild_worker_pool" "private_pool" {
  provider = google-beta

  project  = data.tfe_outputs.foundation.values.svc_project_id
  name     = var.name
  location = var.region
  worker_config {
    disk_size_gb   = 100
    machine_type   = "e2-standard-4"
    no_external_ip = true
  }
  network_config {
    peered_network = "projects/${data.tfe_outputs.foundation.values.host_project_number}/global/networks/${data.tfe_outputs.foundation.values.vpc_name}"
  }
}
