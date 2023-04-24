globals {
  raw_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_raw.tf" {
  content {
    module "raw" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/raw"

      app           = global.raw_config.app
      namespace     = global.raw_config.namespace
      repository    = global.raw_config.repository
      values        = [yamlencode(global.raw_config.values)]
      set           = global.raw_config.set
      set_sensitive = global.raw_config.set_sensitive
    }

    output "chart" {
      value = module.raw.chart
    }
  }
}
