resource "google_cloudbuild_trigger" "filename-trigger" {
  project = data.tfe_outputs.foundation.values.svc_project_id

  trigger_template {
    branch_name = "main"
    repo_name   = "github_abelgana_tfc_poc"
  }

  filename = "postgresql/cloudbuild.yaml"
}
