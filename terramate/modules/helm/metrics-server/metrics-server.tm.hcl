globals {
  metrics_server_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_metrics_server.tf" {
  content {
    module "metrics_server" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/metrics-server"

      app           = global.metrics_server_config.app
      namespace     = global.metrics_server_config.namespace
      repository    = global.metrics_server_config.repository
      values        = yamlencode(global.metrics_server_config.values)
      set           = global.metrics_server_config.set
      set_sensitive = global.metrics_server_config.set_sensitive
    }

    output "chart" {
      value = module.metrics_server
    }
  }
}
