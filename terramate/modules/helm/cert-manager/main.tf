locals {
  app_defaults = {
    deploy                = 1
    name                  = "cert-manager"
    chart                 = "cert-manager"
    version               = "v1.10.1"
    create_namespace      = true
    reuse_values          = false
    reset_values          = true
    max_history           = 12
    render_subchart_notes = false
    timeout               = 600
  }

  app_merged = merge(local.app_defaults, var.app)

  values_defaults = {
    global = {
      leaderElection = {
        namespace = var.namespace
      }
    }
    installCRDs  = true
    featureGates = "ExperimentalCertificateSigningRequestControllers=true"
    ingressShim = {
      defaultIssuerName = "default-issuer"
      defaultIssuerKind = "ClusterIssuer"
    }
    prometheus = {
      enabled = false
    }
  }
}

module "cert_manager" {
  source  = "terraform-module/release/helm"
  version = "2.8.0"

  namespace         = var.namespace
  repository        = var.repository
  repository_config = var.repository_config
  app               = merge(local.app_defaults, var.app)
  set               = var.set
  set_sensitive     = var.set_sensitive
  values            = flatten([yamlencode(local.values_defaults), var.values])
}
