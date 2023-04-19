// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "elasticsearch" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/elasticsearch"
  values = yamlencode({})
}
output "chart" {
  value = module.elasticsearch
}
