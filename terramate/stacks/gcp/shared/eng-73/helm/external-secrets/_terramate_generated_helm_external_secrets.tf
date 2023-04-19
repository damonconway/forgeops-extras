// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

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
  account_id   = replace(substr("eng-73-shared-external-secrets", 0, 30), "/[^a-z0-9]$/", "")
  display_name = substr("External Secrets service account for k8s cluster: eng-73-shared", 0, 100)
}
resource "google_project_iam_member" "external_secrets_admin" {
  member  = "serviceAccount:${google_service_account.external_secrets.email}"
  project = "engineering-devops"
  role    = "roles/secretmanager.admin"
}
resource "google_service_account_iam_member" "external_secrets_workload_identity_user" {
  member             = "serviceAccount:${kubernetes_config_map.gke_data.data.identity_namespace}[external-secrets/external-secrets]"
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.external_secrets.name
}
resource "kubernetes_config_map" "gke_data" {
  metadata {
    name      = "gke-data"
    namespace = "terramate-data"
  }
}
module "external_secrets" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/external-secrets"
  values = [
    yamlencode({}),
    yamlencode(local.values),
  ]
}
output "chart" {
  value = module.external_secrets
}
