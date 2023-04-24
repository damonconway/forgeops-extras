globals {
  ds_operator_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_ds_operator.tf" {
  content {
    module "ds_operator" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/ds-operator"

      app           = global.ds_operator_config.app
      namespace     = global.ds_operator_config.namespace
      repository    = global.ds_operator_config.repository
      values        = [yamlencode(global.ds_operator_config.values)]
      set           = global.ds_operator_config.set
      set_sensitive = global.ds_operator_config.set_sensitive
    }

    output "chart" {
      value = module.ds_operator.chart
    }
  }
}
