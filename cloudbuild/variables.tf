variable "region" {
  type        = string
  description = "The region of the Cloud SQL resources"
  default     = "us-east4"
}

variable "name" {
  type    = string
  default = "private-pool"
}

variable "access_token" {
  type = string
}
