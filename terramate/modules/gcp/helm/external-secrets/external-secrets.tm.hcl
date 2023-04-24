globals {
  external_secrets_svs_acct = {
    role = "roles/secretmanager.admin"
  }
  external_secrets_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_external_secrets.tf" {
  content {
    locals {
      values = {
        serviceAccount = {
          annotations = {
            "iam.gke.io/gcp-service-account" = google_service_account.external_secrets.email
          }
        }
      }
    }

    resource "google_service_account" "external_secrets" {
      account_id   = replace(substr("${global.cluster_name}-external-secrets", 0, 30), "/[^a-z0-9]$/", "")
      display_name = substr("External Secrets service account for k8s cluster: ${global.cluster_name}", 0, 100)
    }

    resource "google_project_iam_member" "external_secrets_admin" {
      role    = global.external_secrets_svs_acct.role
      member  = "serviceAccount:${google_service_account.external_secrets.email}"
      project = global.project
    }

    resource "google_service_account_iam_member" "external_secrets_workload_identity_user" {
      service_account_id = google_service_account.external_secrets.name
      role               = "roles/iam.workloadIdentityUser"
      member             = "serviceAccount:${data.kubernetes_config_map.gke_data.data.identity_namespace}[external-secrets/external-secrets]"
    }

    data "kubernetes_config_map" "gke_data" {
      metadata {
        name      = global.gke_data_config_map_name
        namespace = global.k8s_data_sharing_namespace
      }
    }

    module "external_secrets" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/external-secrets"

      app           = global.external_secrets_config.app
      namespace     = global.external_secrets_config.namespace
      repository    = global.external_secrets_config.repository
      values        = flatten([yamlencode(global.external_secrets_config.values), yamlencode(local.values)])
      set           = global.external_secrets_config.set
      set_sensitive = global.external_secrets_config.set_sensitive
    }

    output "chart" {
      value = module.external_secrets.chart
    }
  }
}
