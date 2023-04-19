// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

locals {
  values = {
    platform = {
      ingress = {
        className = "nginx"
        hosts = [
          "identity-platform.${data.google_compute_address.ingress.address}.nip.io",
        ]
      }
    }
  }
}
data_source "google_compute_address" "ingress" {
  name = "eng-73-shared-us-east1"
}
module "identity_platform" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/identity-platform"
  values = flatten([
    yamlencode(local.values),
    ({
      ds_cts = {
        kind = "DirectoryService"
        volumeClaimSpec = {
          accessModes = [
            "ReadWriteOnce",
          ]
          resources = {
            requests = {
              storage = "10Gi"
            }
          }
          storageClassName = "fast"
        }
      }
      ds_idrepo = {
        kind = "DirectoryService"
        volumeClaimSpec = {
          accessModes = [
            "ReadWriteOnce",
          ]
          resources = {
            requests = {
              storage = "10Gi"
            }
          }
          storageClassName = "fast"
        }
      }
    }),
  ])
}
output "chart" {
  value = module.identity_platform.chart
}
