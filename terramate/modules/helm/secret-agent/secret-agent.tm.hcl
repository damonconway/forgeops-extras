globals {
  secret-agent_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_secret-agent.tf" {
  content {
    module "secret-agent" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/secret-agent"

      app           = global.secret-agent_config.app
      namespace     = global.secret-agent_config.namespace
      repository    = global.secret-agent_config.repository
      values        = yamlencode(global.secret-agent_config.values)
      set           = global.secret-agent_config.set
      set_sensitive = global.secret-agent_config.set_sensitive
    }

    output "chart" {
      value = module.secret-agent
    }
  }
}
