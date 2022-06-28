module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0"

  project_id   = module.host_project.project_id
  network_name = "shared-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.4.0.0/22"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "192.168.0.0/22"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-pods"
        ip_cidr_range = "10.0.0.0/14"
      },
      {
        range_name    = "subnet-01-secondary-svc-01"
        ip_cidr_range = "10.5.0.0/20"
      },
    ]
  }
}

resource "google_compute_router" "router" {
  name    = "${module.vpc.subnets_regions[0]}-router"
  region  = module.vpc.subnets_regions[0]
  network = module.vpc.network_name
  project = module.vpc.project_id
}

resource "google_compute_router_nat" "nat_ip" {
  name                               = "${google_compute_router.router.region}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ips                            = google_compute_address.nat_ip.*.self_link
  project                            = module.vpc.project_id
  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_address" "nat_ip" {
  name         = "${var.region}-nat-ip"
  address_type = "EXTERNAL"
  region       = module.vpc.subnets_regions[0]
  project      = module.vpc.project_id
}

resource "google_compute_global_address" "peering_redis" {
  name          = "redis-peering-cidr"
  address       = "10.64.0.0"
  purpose       = "VPC_PEERING"
  prefix_length = "16"
  address_type  = "INTERNAL"
  network       = module.vpc.network_id
  project       = module.host_project.project_id
}

resource "google_compute_global_address" "peering_postresql" {
  name          = "postresql-peering-cidr"
  address       = "10.128.0.0"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = "16"
  network       = module.vpc.network_id
  project       = module.host_project.project_id
}

resource "google_service_networking_connection" "peering_svc" {
  network                 = module.vpc.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.peering_redis.name, google_compute_global_address.peering_postresql.name]
}
