locals {
  app_defaults = {
    deploy                = 1
    name                  = "raw"
    chart                 = "raw"
    version               = "1.1.0"
    create_namespace      = true
    reuse_values          = false
    reset_values          = true
    max_history           = 12
    render_subchart_notes = false
    timeout               = 600
  }
}

module "raw" {
  source  = "terraform-module/release/helm"
  version = "2.8.1"

  namespace     = var.namespace
  repository    = var.repository
  app           = merge(local.app_defaults, var.app)
  set           = var.set
  set_sensitive = var.set_sensitive
  values        = var.values
}
