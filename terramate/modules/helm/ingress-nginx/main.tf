locals {
  app_defaults = {
    name                  = "ingress-nginx",
    chart                 = "ingress-nginx",
    version               = "4.1.1",
    namespace             = "ingress-nginx"
    create_namespace      = true
    reuse_values          = false
    reset_values          = true
    max_history           = 12
    render_subchart_notes = false
    timeout               = 600
  }

  values_defaults = <<-EOF
  controller:
    kind: Deployment
    replicaCount: 2
    service:
      type: LoadBalancer
      externalTrafficPolicy: Local
      omitClusterIP: true
    publishService:
      enabled: true
    stats:
      enabled: true
      service:
        omitClusterIP: true
  EOF
}

module "ingress_nginx" {
  source  = "terraform-module/release/helm"
  version = "2.6.0"

  namespace     = var.namespace
  repository    = var.repository
  app           = merge(local.app_defaults, var.app)
  set           = var.set
  set_sensitive = var.set_sensitive
  values        = flatten([local.values_defaults, var.values])
}
