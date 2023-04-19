// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "secret_agent" {
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
  value = module.secret_agent
}
