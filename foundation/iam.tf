// module "region_projects_iam_bindings" {
//   source  = "terraform-google-modules/iam/google//modules/projects_iam"
//   version = "~> 7.4"
//
//   projects = [module.svc_project.project_id]
//
//   bindings = {
//     "roles/compute.networkUser" = [
//       local.svc_project_gke_sa,
//     ]
//     "roles/compute.securityAdmin" = [
//       local.svc_project_gke_sa,
//     ]
//     "roles/container.hostServiceAgentUser" = [
//       local.svc_project_gke_sa,
//     ]
//   }
// }
//
// locals {
//   svc_project_gke_sa = "serviceAccount:service-${module.host_project.project_number}@container-engine-robot.iam.gserviceaccount.com"
// }
//
