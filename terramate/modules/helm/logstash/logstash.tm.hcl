globals {
  logstash_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_logstash.tf" {
  content {
    module "logstash" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/logstash"

      app           = global.logstash_config.app
      namespace     = global.logstash_config.namespace
      repository    = global.logstash_config.repository
      values        = yamlencode(global.logstash_config.values)
      set           = global.logstash_config.set
      set_sensitive = global.logstash_config.set_sensitive
    }

    output "chart" {
      value = module.logstash
    }
  }
}
