// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "secret-agent" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/secret-agent"
  values = yamlencode({})
}
output "chart" {
  value = module.secret-agent
}
