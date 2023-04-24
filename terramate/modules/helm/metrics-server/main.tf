locals {
  app_defaults = {
    deploy                = 1
    name                  = "metrics-server"
    chart                 = "metrics-server"
    version               = "3.7.0"
    reuse_values          = false
    reset_values          = true
    max_history           = 12
    render_subchart_notes = false
    timeout               = 600
  }

  values_defaults = {
    priorityClassName = "system-node-critical"
    args = [
      "--kubelet-preferred-address-types=InternalIP",
      "--kubelet-insecure-tls"
    ]
    service = {
      labels = {
        "kubernetes.io/cluster-service" = "true"
        "kubernetes.io/name"            = "Metrics-server"
      }
    }
  }
}

module "metrics_server" {
  source  = "terraform-module/release/helm"
  version = "2.8.0"

  namespace     = var.namespace
  repository    = var.repository
  app           = merge(local.app_defaults, var.app)
  set           = var.set
  set_sensitive = var.set_sensitive
  values        = flatten([yamlencode(local.values_defaults), var.values])
}
