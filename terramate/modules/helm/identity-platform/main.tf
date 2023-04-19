locals {
  app_defaults = {
    name                  = "identity-platform"
    chart                 = "identity-platform"
    version               = null
    create_namespace      = true
    reuse_values          = false
    reset_values          = true
    force_update          = true
    max_history           = 12
    render_subchart_notes = false
    timeout               = 600
  }

  values_defaults = {
    timestamp     = timestamp()
    ldif_importer = false
    storage = {
      storage_class = {
        name = "fast"
        create = {
          provisioner = "pd.csi.storage.gke.io"
          parameters = {
            type = "pd-ssd"
          }
        }
      }
      volume_snapshot_class = {
        name = "ds-snapshot-class"
        create = {
          driver = "pd.csi.storage.gke.io"
        }
      }
    }
  }
}

module "identity_platform" {
  source  = "terraform-module/release/helm"
  version = "2.6.0"

  namespace     = var.namespace
  repository    = var.repository
  app           = merge(local.app_defaults, var.app)
  set           = var.set
  set_sensitive = var.set_sensitive
  values        = flatten([yamlencode(local.values_defaults), var.values])
}
