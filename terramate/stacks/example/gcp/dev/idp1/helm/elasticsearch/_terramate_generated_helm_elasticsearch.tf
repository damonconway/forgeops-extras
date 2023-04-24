// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "elasticsearch" {
  app = {
    deploy = 0
  }
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../../terramate/modules/helm/elasticsearch"
  values = [
    yamlencode({}),
  ]
}
output "chart" {
  value = module.elasticsearch.chart
}
