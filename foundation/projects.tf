module "host_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 11.3"

  name                           = var.host_project
  random_project_id              = true
  org_id                         = var.org_id
  billing_account                = var.billing_id
  enable_shared_vpc_host_project = true
  activate_apis                  = var.host_project_apis
  folder_id                      = module.main_folder.id
}

module "svc_project" {
  source  = "terraform-google-modules/project-factory/google//modules/svpc_service_project"
  version = "~> 11.3"

  name              = var.svc_project
  random_project_id = true
  org_id            = var.org_id
  billing_account   = var.billing_id
  shared_vpc        = module.host_project.project_id
  activate_apis     = var.svc_project_apis
  folder_id         = module.main_folder.id
  shared_vpc_subnets = [
    format("projects/%s/regions/%s/subnetworks/%s", module.host_project.project_id, var.region, "subnet-01")
  ]
  depends_on = [
    module.host_project,
    module.vpc,
  ]
}
