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
      passed_values = global.metrics_server_config.values
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

      app           = global.metrics_server_config.app
      namespace     = global.metrics_server_config.namespace
      repository    = global.metrics_server_config.repository
      values        = flatten([local.passed_values, yamlencode(local.values)])
      set           = global.metrics_server_config.set
      set_sensitive = global.metrics_server_config.set_sensitive
    }
  }
}
