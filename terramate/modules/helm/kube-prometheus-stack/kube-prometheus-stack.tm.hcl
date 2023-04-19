globals {
  kube_prometheus_stack_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_kube_prometheus_stack.tf" {
  content {
    module "kube_prometheus_stack" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/kube-prometheus-stack"

      app           = global.kube_prometheus_stack_config.app
      namespace     = global.kube_prometheus_stack_config.namespace
      repository    = global.kube_prometheus_stack_config.repository
      values        = yamlencode(global.kube_prometheus_stack_config.values)
      set           = global.kube_prometheus_stack_config.set
      set_sensitive = global.kube_prometheus_stack_config.set_sensitive
    }

    output "chart" {
      value = module.kube_prometheus_stack
    }
  }
}
