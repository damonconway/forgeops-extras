locals {
  app_defaults = {
    deploy                = 1
    name                  = "external-dns",
    chart                 = "external-dns",
    version               = "6.9.0",
    create_namespace      = true
    reuse_values          = false
    reset_values          = true
    max_history           = 12
    render_subchart_notes = false
    timeout               = 600
  }

  values_defaults = {
    image = {
      registry   = "us.gcr.io"
      repository = "k8s-artifacts-prod/external-dns/external-dns"
      tag        = "v0.12.2"
    }
    sources = [
      "ingress"
    ]
    dryRun   = false
    loglevel = "info"
    policy   = "sync"
  }
}

module "external_dns" {
  source  = "terraform-module/release/helm"
  version = "2.8.1"

  namespace     = var.namespace
  repository    = var.repository
  app           = merge(local.app_defaults, var.app)
  set           = var.set
  set_sensitive = var.set_sensitive
  values        = flatten([yamlencode(local.values_defaults), var.values])
}
