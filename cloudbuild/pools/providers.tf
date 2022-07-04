provider "google" {
  project      = data.tfe_outputs.foundation.values.svc_project_id
  access_token = var.access_token
  region       = var.region
}

provider "google-beta" {
  project      = data.tfe_outputs.foundation.values.svc_project_id
  access_token = var.access_token
  region       = var.region
}
