globals {
  identity_platform_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_identity_platform.tf" {
  content {
    locals {
      values = {
        platform = {
          ingress = {
            className = global.ingress_class
            hosts = [
              "identity-platform.${data.google_compute_address.ingress.address}.nip.io"
            ]
          }
        }
      }
    }

    data_source "google_compute_address" "ingress" {
      name = "${global.cluster_name}-${global.location}"
    }

    module "identity_platform" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/identity-platform"

      app           = global.identity_platform_config.app
      namespace     = global.identity_platform_config.namespace
      repository    = global.identity_platform_config.repository
      values        = flatten([yamlencode(local.values), (global.identity_platform_config.values)])
      set           = global.identity_platform_config.set
      set_sensitive = global.identity_platform_config.set_sensitive
    }

    output "chart" {
      value = module.identity_platform.chart
    }
  }
}
