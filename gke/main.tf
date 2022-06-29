module "kubernetes-engine" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "20.0.0"

  project_id                 = data.tfe_outputs.foundation.values.svc_project_id
  name                       = var.name
  regional                   = var.regional
  region                     = var.region
  network                    = data.tfe_outputs.foundation.values.vpc_name
  network_project_id         = data.tfe_outputs.foundation.values.host_project_id
  subnetwork                 = data.tfe_outputs.foundation.values.subnet_1_name
  kubernetes_version         = var.kubernetes_version
  master_authorized_networks = var.master_authorized_networks
  http_load_balancing        = var.http_load_balancing
  ip_range_pods              = data.tfe_outputs.foundation.values.svc_pod_subnet
  ip_range_services          = data.tfe_outputs.foundation.values.svc_svc_subnet
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = var.master_ipv4_cidr_block
  identity_namespace         = var.identity_namespace
  initial_node_count         = var.initial_node_count
  remove_default_node_pool   = true
  enable_shielded_nodes      = true
  datapath_provider          = "ADVANCED_DATAPATH"


  node_pools = [
    {
      name                        = "gke-default-node-pool"
      machine_type                = "e2-standard-2"
      node_location               = var.region
      min_count                   = 1
      max_count                   = 1
      auto_upgrade                = false
      version                     = var.kubernetes_version
      enable_secure_boot          = true
      enable_integrity_monitoring = true
      spot                        = true
    },
  ]
}
