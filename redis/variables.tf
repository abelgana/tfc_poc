variable "region" {
  description = "The GCP region to use."
  type        = string
  default     = "us-east4"
}

variable "name" {
  description = "The ID of the instance or a fully qualified identifier for the instance."
  type        = string
}

variable "tier" {
  description = "The service tier of the instance. https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Tier"
  type        = string
  default     = "STANDARD_HA"
}

variable "memory_size_gb" {
  description = "Redis memory size in GiB. Defaulted to 1 GiB"
  type        = number
  default     = 1
}

variable "redis_version" {
  description = "The version of Redis software."
  type        = string
  default     = "REDIS_6_X"
}

variable "display_name" {
  description = "An arbitrary and optional user-provided name for the instance."
  type        = string
  default     = "Redis cluster"
}

variable "connect_mode" {
  description = "The connection mode of the Redis instance. Can be either DIRECT_PEERING or PRIVATE_SERVICE_ACCESS. The default connect mode if not provided is DIRECT_PEERING."
  type        = string
  default     = "PRIVATE_SERVICE_ACCESS"
}

variable "labels" {
  description = "The resource labels to represent user provided metadata."
  type        = map(string)
  default     = null
}

variable "auth_enabled" {
  description = "Indicates whether OSS Redis AUTH is enabled for the instance. If set to true AUTH is enabled on the instance."
  type        = bool
  default     = false
}

variable "transit_encryption_mode" {
  description = "The TLS mode of the Redis instance, If not provided, TLS is enabled for the instance."
  type        = string
  default     = "SERVER_AUTHENTICATION"
}

variable "access_token" {
  type = string
}
