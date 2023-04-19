locals {
  app_defaults = {
    name                  = "trust-manager"
    chart                 = "trust-manager"
    version               = "v0.3.0"
    create_namespace      = true
    reuse_values          = false
    reset_values          = true
    max_history           = 12
    render_subchart_notes = false
    timeout               = 600
  }

  values_defaults = {
    global = {
      leaderElection = {
        namespace = var.namespace
      }
    }
    installCRDs  = true
    featureGates = "ExperimentaltrustificateSigningRequestControllers=true"
    ingressShim = {
      defaultIssuerName = "default-issuer"
      defaultIssuerKind = "ClusterIssuer"
    }
    prometheus = {
      enabled = false
    }
  }
}

module "trust_manager" {
  source  = "terraform-module/release/helm"
  version = "2.6.0"

  namespace     = var.namespace
  repository    = var.repository
  app           = merge(local.app_defaults, var.app)
  set           = var.set
  set_sensitive = var.set_sensitive
  values        = flatten([yamlencode(local.values_defaults), var.values])
}
