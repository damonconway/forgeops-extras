globals "identity_platform_config" {
  values = {
    ds_idrepo = {
      kind = "DirectoryService"
      volumeClaimSpec = {
        storageClassName = "fast"
        accessModes = [
          "ReadWriteOnce"
        ]
        resources = {
          requests = {
            storage = "10Gi"
          }
        }
      }
    }
    ds_cts = {
      kind = "DirectoryService"
      volumeClaimSpec = {
        storageClassName = "fast"
        accessModes = [
          "ReadWriteOnce"
        ]
        resources = {
          requests = {
            storage = "10Gi"
          }
        }
      }
    }
  }
}
