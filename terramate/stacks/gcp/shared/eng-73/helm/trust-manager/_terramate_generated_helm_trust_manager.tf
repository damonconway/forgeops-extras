// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "trust_manager" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/trust-manager"
  values = yamlencode({})
}
output "chart" {
  value = module.trust_manager
}
