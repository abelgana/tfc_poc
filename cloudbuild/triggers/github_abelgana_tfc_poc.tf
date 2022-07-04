// resource "google_cloudbuild_trigger" "filename-trigger" {
//   project = data.tfe_outputs.foundation.values.svc_project_id
//
//   trigger_template {
//     branch_name = "main"
//     repo_name   = "github_abelgana_tfc_poc"
//   }
//
//   filename = "postgresql/cloudbuild.yaml"
// }

resource "google_cloudbuild_trigger" "build-trigger" {
  project = data.tfe_outputs.foundation.values.svc_project_id
  trigger_template {
    branch_name = "main"
    repo_name   = "github_abelgana_tfc_poc"
  }

  build {
    step {
      name    = "bash"
      args    = ["echo", "I did run"]
      timeout = "120s"
    }

    options {
      dynamic_substitutions = true
      log_streaming_option  = "STREAM_OFF"
      worker_pool           = "projects/$PROJECT_ID/locations/us-east4/workerPools/private-pool"
    }
  }
}
