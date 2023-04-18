globals {
  ingress_nginx_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = []
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_ingress_nginx.tf" {
  content {
    locals {
      passed_values = global.ingress_nginx_config.values
      values = {
        controller = {
          service = {
            loadBalancerIP = google_compute_address.ingress.address
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

      app           = global.ingress_nginx_config.app
      namespace     = global.ingress_nginx_config.namespace
      repository    = global.ingress_nginx_config.repository
      values        = flatten([local.passed_values, yamlencode(local.values)])
      set           = global.ingress_nginx_config.set
      set_sensitive = global.ingress_nginx_config.set_sensitive
    }
  }
}
