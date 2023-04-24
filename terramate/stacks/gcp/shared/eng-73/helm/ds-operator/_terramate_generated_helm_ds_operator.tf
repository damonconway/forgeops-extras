// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "ds_operator" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/ds-operator"
  values = [
    yamlencode({}),
  ]
}
output "chart" {
  value = module.ds_operator.chart
}
