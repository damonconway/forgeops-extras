// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

locals {
  values = {
    controller = {
      service = {
        loadBalancerIP = google_compute_address.ingress.address
      }
    }
  }
}
resource "google_compute_address" "ingress" {
  address_type = "EXTERNAL"
  name         = "cluster1-dev-us-east1"
}
module "ingress_nginx" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../../terramate/modules/helm/ingress-nginx"
  values = flatten([
    yamlencode({}),
    yamlencode(local.values),
  ])
}
output "chart" {
  value = module.ingress_nginx.chart
}
