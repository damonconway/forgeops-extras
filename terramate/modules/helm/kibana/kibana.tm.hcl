globals {
  kibana_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_kibana.tf" {
  content {
    module "kibana" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/kibana"

      app           = global.kibana_config.app
      namespace     = global.kibana_config.namespace
      repository    = global.kibana_config.repository
      values        = yamlencode(global.kibana_config.values)
      set           = global.kibana_config.set
      set_sensitive = global.kibana_config.set_sensitive
    }

    output "chart" {
      value = module.kibana.chart
    }
  }
}
