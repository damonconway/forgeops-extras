// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

locals {
  values = {
    provider = "google"
    google = {
      project = "engineering-devops"
    }
    txtOwnerId = "eng-73-shared.us-east1"
    serviceAccount = {
      annotations = {
        "iam.gke.io/gcp-service-account" = google_service_account.external_dns.email
      }
    }
  }
}
resource "google_service_account" "external_dns" {
  account_id   = replace(substr("eng-73-shared-external-dns", 0, 30), "/[^a-z0-9]$/", "")
  display_name = substr("ExternalDNS service account for k8s cluster: eng-73-shared", 0, 100)
}
resource "google_project_iam_member" "external_dns_admin" {
  member  = "serviceAccount:${google_service_account.external_dns.email}"
  project = "engineering-devops"
  role    = "roles/dns.admin"
}
resource "google_service_account_iam_member" "external_dns_workload_identity_user" {
  member             = "serviceAccount:${kubernetes_config_map.gke_data.data.identity_namespace}[external-dns/external-dns]"
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.external_dns.name
}
data "kubernetes_config_map" "gke_data" {
  metadata {
    name      = "gke-data"
    namespace = "terramate-data"
  }
}
module "external_dns" {
  app        = {}
  namespace  = null
  repository = null
  set = [
  ]
  set_sensitive = [
  ]
  source = "../../../../../../../terramate/modules/helm/external-dns"
  values = [
    yamlencode({}),
    yamlencode(local.values),
  ]
}
output "chart" {
  value = module.external_dns
}
