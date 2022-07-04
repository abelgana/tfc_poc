terraform {
  required_providers {
    http-full = {
      source = "salrashid123/http-full"
    }
  }
}

provider "http-full" {}

# HTTP POST
data "http" "example" {
  provider = http-full
  url      = "https://cloudbuild.googleapis.com/v1/projects/${data.tfe_outputs.foundation.values.svc_project_id}/triggers/${data.tfe_outputs.tfc_poc_webhook.values.trigger_name}:webhookkey${data.tfe_outputs.tfc_poc_webhook.values.api_key}&secret${var.secret}"

  method = "POST"

  request_headers = {
    content-type = "application/json"
  }
  request_body = jsonencode({
    date = base64encode(timestamp()),
  })
}

output "data" {
  value = jsondecode(data.http.example.body)
}
