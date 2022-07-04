resource "google_secret_manager_secret" "webhook_trigger_secret_key" {
  secret_id = "webhook_trigger-secret-key-1"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "webhook_trigger_secret_key_data" {
  secret = google_secret_manager_secret.webhook_trigger_secret_key.id

  secret_data = "secretkeygoeshere"
}

data "google_iam_policy" "secret_accessor" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    members = [
      "serviceAccount:service-${data.tfe_outputs.foundation.values.svc_project_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com",
    ]
  }
}

resource "google_secret_manager_secret_iam_policy" "policy" {
  project     = google_secret_manager_secret.webhook_trigger_secret_key.project
  secret_id   = google_secret_manager_secret.webhook_trigger_secret_key.secret_id
  policy_data = data.google_iam_policy.secret_accessor.policy_data
}


resource "google_cloudbuild_trigger" "webhook-config-trigger" {
  name        = "webhook-trigger"
  description = "acceptance test example webhook build trigger"

  webhook_config {
    secret = google_secret_manager_secret_version.webhook_trigger_secret_key_data.id
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
