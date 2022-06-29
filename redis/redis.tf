module "redis_memorystore" {
  source  = "terraform-google-modules/memorystore/google"
  version = "4.3.0"

  region                  = var.region
  project                 = data.tfe_outputs.foundation.values.svc_project_id
  name                    = var.name
  authorized_network      = data.tfe_outputs.foundation.values.vpc_id
  tier                    = var.tier
  memory_size_gb          = var.memory_size_gb
  display_name            = var.display_name
  reserved_ip_range       = data.tfe_outputs.foundation.values.redis_ip_range
  connect_mode            = var.connect_mode
  redis_version           = var.redis_version
  labels                  = var.labels
  transit_encryption_mode = var.transit_encryption_mode
}
