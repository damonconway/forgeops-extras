// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "cert_manager" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/cert-manager"
  values = yamlencode({})
}
module "cluster_issuers" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/raw"
  values = yamlencode({
    resources = [
      {
        apiVersion = "cert-manager.io/v1"
        kind       = "ClusterIssuer"
        metadata = {
          name = "default-issuer"
        }
        spec = {
          acme = {
            email = "forgeops-team@forgerock.com"
            privateKeySecretRef = {
              name = "letsencrypt-default"
            }
            server = "https://acme-v02.api.letsencrypt.org/directory"
            solvers = [
              {
                http01 = {
                  ingress = {
                    class = "nginx"
                  }
                }
              },
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
            email = "forgeops-team@forgerock.com"
            privateKeySecretRef = {
              name = "letsencrypt-production"
            }
            server = "https://acme-v02.api.letsencrypt.org/directory"
            solvers = [
              {
                http01 = {
                  ingress = {
                    class = "nginx"
                  }
                }
              },
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
            email = "forgeops-team@forgerock.com"
            privateKeySecretRef = {
              name = "letsencrypt-staging"
            }
            server = "https://acme-staging-v02.api.letsencrypt.org/directory"
            solvers = [
              {
                http01 = {
                  ingress = {
                    class = "nginx"
                  }
                }
              },
            ]
          }
        }
      },
    ]
  })
}
output "chart" {
  value = module.cert_manager
}
output "cluster_issuers" {
  value = module.cluster_issuers
}
