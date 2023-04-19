globals {
  cert_manager_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }

  cert_manager_cluster_issuers_config = {
    app           = {}
    namespace     = tm_try(global.cert_manager_config.namespace, "cert-manager")
    repository    = null
    set           = []
    set_sensitive = []
    values = {
      resources = [
        {
          apiVersion = "cert-manager.io/v1"
          kind       = "ClusterIssuer"
          metadata = {
            name = "default-issuer"
          }
          spec = {
            acme = {
              # The ACME server URL.
              server = "https://acme-v02.api.letsencrypt.org/directory"
              # Email address used for ACME registration.
              email = global.letsencrypt_email
              # Name of a secret used to store the ACME account private key.
              privateKeySecretRef = {
                name = "letsencrypt-default"
              }
              solvers = [
                {
                  http01 = {
                    ingress = {
                      class = global.ingress_class
                    }
                  }
                }
              ]
            }
          }
        },
        {
          apiVersion = "cert-manager.io/v1"
          kind       = "ClusterIssuer"
          metadata = {
            name = "letsencrypt-production"
          }
          spec = {
            acme = {
              # The ACME server URL.
              server = "https://acme-v02.api.letsencrypt.org/directory"
              # Email address used for ACME registration.
              email = global.letsencrypt_email
              # Name of a secret used to store the ACME account private key.
              privateKeySecretRef = {
                name = "letsencrypt-production"
              }
              solvers = [
                {
                  http01 = {
                    ingress = {
                      class = global.ingress_class
                    }
                  }
                }
              ]
            }
          }
        },
        {
          apiVersion = "cert-manager.io/v1"
          kind       = "ClusterIssuer"
          metadata = {
            name = "letsencrypt-staging"
          }
          spec = {
            acme = {
              # The ACME server URL.
              server = "https://acme-staging-v02.api.letsencrypt.org/directory"
              # Email address used for ACME registration.
              email = global.letsencrypt_email
              # Name of a secret used to store the ACME account private key.
              privateKeySecretRef = {
                name = "letsencrypt-staging"
              }
              solvers = [
                {
                  http01 = {
                    ingress = {
                      class = global.ingress_class
                    }
                  }
                }
              ]
            }
          }
        }
      ]
    }
  }
}

generate_hcl "_terramate_generated_helm_cert_manager.tf" {
  content {
    module "cert_manager" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/cert-manager"

      app           = global.cert_manager_config.app
      namespace     = global.cert_manager_config.namespace
      repository    = global.cert_manager_config.repository
      values        = yamlencode(global.cert_manager_config.values)
      set           = global.cert_manager_config.set
      set_sensitive = global.cert_manager_config.set_sensitive
    }

    module "cluster_issuers" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/raw"

      app           = global.cert_manager_cluster_issuers_config.app
      namespace     = global.cert_manager_cluster_issuers_config.namespace
      repository    = global.cert_manager_cluster_issuers_config.repository
      values        = yamlencode(global.cert_manager_cluster_issuers_config.values)
      set           = global.cert_manager_cluster_issuers_config.set
      set_sensitive = global.cert_manager_cluster_issuers_config.set_sensitive
    }

    output "chart" {
      value = module.cert_manager.chart
    }

    output "cluster_issuers" {
      value = module.cluster_issuers.chart
    }
  }
}
