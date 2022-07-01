provider "google" {
  access_token = var.access_token
  region       = var.region
}

provider "google-beta" {
  access_token = var.access_token
  region       = var.region
}
