globals {
  trust_manager_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_trust_manager.tf" {
  content {
    module "trust_manager" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/trust-manager"

      app           = global.trust_manager_config.app
      namespace     = global.trust_manager_config.namespace
      repository    = global.trust_manager_config.repository
      values        = [yamlencode(global.trust_manager_config.values)]
      set           = global.trust_manager_config.set
      set_sensitive = global.trust_manager_config.set_sensitive
    }

    output "chart" {
      value = module.trust_manager.chart
    }
  }
}
