resource "google_cloudbuild_trigger" "filename-trigger" {
  trigger_template {
    branch_name = "main"
    repo_name   = "github_abelgana_tfc_poc"
  }

  filename = "postgresql/cloudbuild.yaml"
}
