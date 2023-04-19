globals {
  cert_manager_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_cert_manager.tf" {
  content {
    module "cert_manager" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/cert-manager"

      app           = global.cert_manager_config.app
      namespace     = global.cert_manager_config.namespace
      repository    = global.cert_manager_config.repository
      values        = yamlencode(global.cert_manager_config.values)
      set           = global.cert_manager_config.set
      set_sensitive = global.cert_manager_config.set_sensitive
    }

    output "chart" {
      value = module.cert_manager
    }
  }
}
