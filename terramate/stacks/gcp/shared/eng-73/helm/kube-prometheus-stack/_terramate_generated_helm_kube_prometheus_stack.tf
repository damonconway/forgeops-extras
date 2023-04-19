// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "kube_prometheus_stack" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/kube-prometheus-stack"
  values = yamlencode({})
}
output "chart" {
  value = module.kube_prometheus_stack.chart
}
