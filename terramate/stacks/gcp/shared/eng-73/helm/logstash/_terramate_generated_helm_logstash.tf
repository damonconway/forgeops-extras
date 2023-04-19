// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "logstash" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/logstash"
  values = yamlencode({})
}
output "chart" {
  value = module.logstash
}
