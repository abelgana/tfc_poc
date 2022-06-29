output "id" {
  description = "The memorystore instance ID."
  value       = module.redis_memorystore.id
}

output "host" {
  description = "The IP address of the instance."
  value       = module.redis_memorystore.host
}

output "port" {
  description = "The port number of the exposed Redis endpoint."
  value       = module.redis_memorystore.port
}

output "region" {
  description = "The region the instance lives in."
  value       = module.redis_memorystore.region
}

output "current_location_id" {
  description = "The current zone where the Redis endpoint is placed."
  value       = module.redis_memorystore.current_location_id
}

output "persistence_iam_identity" {
  description = "Cloud IAM identity used by import/export operations. Format is 'serviceAccount:'. May change over time"
  value       = module.redis_memorystore.persistence_iam_identity
}

output "auth_string" {
  description = "AUTH String set on the instance. This field will only be populated if auth_enabled is true."
  value       = module.redis_memorystore.auth_string
  sensitive   = true
}
