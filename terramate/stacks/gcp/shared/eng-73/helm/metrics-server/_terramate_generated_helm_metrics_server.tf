// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "metrics_server" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/metrics-server"
  values = yamlencode({})
}
output "chart" {
  value = module.metrics_server
}
