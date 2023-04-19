globals {
  elasticsearch_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_elasticsearch.tf" {
  content {
    module "elasticsearch" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/elasticsearch"

      app           = global.elasticsearch_config.app
      namespace     = global.elasticsearch_config.namespace
      repository    = global.elasticsearch_config.repository
      values        = yamlencode(global.elasticsearch_config.values)
      set           = global.elasticsearch_config.set
      set_sensitive = global.elasticsearch_config.set_sensitive
    }

    output "chart" {
      value = module.elasticsearch
    }
  }
}
