variable "org_id" {
  type = string
}

variable "billing_id" {
  type = string
}

variable "folder_names" {
  type    = list(string)
  default = ["demos"]
}

variable "host_project" {
  type        = string
  default     = "host-project"
  description = "Host Project name"
}

variable "svc_project" {
  type        = string
  default     = "svc-project"
  description = "svc Prod"
}

variable "host_project_apis" {
  type    = list(string)
  default = ["servicenetworking.googleapis.com", "container.googleapis.com"]
}

variable "svc_project_apis" {
  type    = list(string)
  default = ["cloudbuild.googleapis.com", "servicenetworking.googleapis.com", "sqladmin.googleapis.com", "container.googleapis.com"]
}

variable "region" {
  type    = string
  default = "us-east4"
}

variable "gke_master_nodes_cidr" {
  default = "172.16.0.0/28"
  type    = string
}

variable "access_token" {
  type = string
}
