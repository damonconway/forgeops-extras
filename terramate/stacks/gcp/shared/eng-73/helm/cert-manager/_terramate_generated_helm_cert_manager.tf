// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "cert_manager" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/cert-manager"
  values = yamlencode({})
}
output "chart" {
  value = module.cert_manager
}
