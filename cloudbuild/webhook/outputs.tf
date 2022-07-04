output "api_key" {
  value     = google_apikeys_key.primary.key_string
  sensitive = true
}

output "trigger_name" {
  value = google_cloudbuild_trigger.webhook-config-trigger.name
}
