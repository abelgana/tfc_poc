variable "access_token" {
  type = string
}

variable "region" {
  type        = string
  description = "The region of the Cloud SQL resources"
  default     = "us-east4"
}

variable "secret" {
  type = string
}
