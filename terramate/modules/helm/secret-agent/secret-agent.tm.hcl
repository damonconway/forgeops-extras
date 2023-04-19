globals {
  secret_agent_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_secret_agent.tf" {
  content {
    module "secret_agent" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/secret-agent"

      app           = global.secret_agent_config.app
      namespace     = global.secret_agent_config.namespace
      repository    = global.secret_agent_config.repository
      values        = yamlencode(global.secret_agent_config.values)
      set           = global.secret_agent_config.set
      set_sensitive = global.secret_agent_config.set_sensitive
    }

    output "chart" {
      value = module.secret_agent.chart
    }
  }
}
