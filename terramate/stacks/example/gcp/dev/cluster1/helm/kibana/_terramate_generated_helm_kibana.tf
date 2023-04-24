// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "kibana" {
  app = {
    deploy = 0
  }
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../../terramate/modules/helm/kibana"
  values = [
    yamlencode({}),
  ]
}
output "chart" {
  value = module.kibana.chart
}
