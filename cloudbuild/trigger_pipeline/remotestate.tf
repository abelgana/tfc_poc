data "tfe_outputs" "tfc_poc_webhook" {
  organization = "belgana"
  workspace    = "tfc_poc_cloud_build_webhook"
}

data "tfe_outputs" "foundation" {
  organization = "belgana"
  workspace    = "tfc_poc_foundation"
}
