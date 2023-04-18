globals {
  app           = {}
  namespace     = null
  repository    = null
  values        = []
  set           = []
  set_sensitive = []
}

generate_hcl "_terramate_generated_helm_ingress_nginx.tf" {
  content {
    locals {
      passed_values = global.values
      values        = {
        controller = {
          service = {
            loadBalancerIP: ${google_compute_address.ingress.address}
          }
        }
      }
    }

    resource "google_compute_address" "ingress" {
      name         = "${global.cluster_name}-${global.location}"
      address_type = "EXTERNAL"
    }

    module "ingress_nginx" {
      source = "/terramate/modules/helm/ingress-nginx"

      app           = global.app
      namespace     = global.namespace
      repository    = global.repository
      values        = flatten([local.passed_values, yamlencode(local.values)])
      set           = global.set
      set_sensitive = global.set_sensitive
    }
  }
}
