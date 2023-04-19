locals {
  app_defaults = {
    name                  = "kibana"
    chart                 = "kibana"
    version               = "7.17.3"
    create_namespace      = true
    reuse_values          = false
    reset_values          = true
    max_history           = 12
    render_subchart_notes = false
    timeout               = 600
  }

  values_defaults = {}
}

module "kibana" {
  source  = "terraform-module/release/helm"
  version = "2.6.0"

  namespace     = var.namespace
  repository    = var.repository
  app           = merge(local.app_defaults, var.app)
  set           = var.set
  set_sensitive = var.set_sensitive
  values        = flatten([yamlencode(local.values_defaults), var.values])
}
