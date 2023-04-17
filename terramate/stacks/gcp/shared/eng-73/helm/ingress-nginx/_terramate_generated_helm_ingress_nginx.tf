// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

locals {
  passed_values = [
  ]
  values = <<-EOT
controller:
  service:
    loadBalancerIP: ${google_compute_address.ingress.address}
EOT

}
resource "google_compute_address" "ingress" {
  address_type = "EXTERNAL"
  name         = "eng-73-shared-us-east1"
}
module "ingress_nginx" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terraform/modules/helm/ingress-nginx"
  values = flatten([
    local.passed_values,
    yamlencode(local.values),
  ])
}
