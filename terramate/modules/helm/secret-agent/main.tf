locals {
  app_defaults = {
    deploy                = 1
    name                  = "secret-agent"
    chart                 = "secret-agent"
    version               = "v1.1.6"
    create_namespace      = true
    reuse_values          = false
    reset_values          = true
    force_update          = true
    max_history           = 12
    render_subchart_notes = false
    timeout               = 600
  }

  values_defaults = {}
}

module "secret_agent" {
  source  = "terraform-module/release/helm"
  version = "2.8.1"

  namespace     = var.namespace
  repository    = var.repository
  app           = merge(local.app_defaults, var.app)
  set           = var.set
  set_sensitive = var.set_sensitive
  values        = flatten([yamlencode(local.values_defaults), var.values])
}
