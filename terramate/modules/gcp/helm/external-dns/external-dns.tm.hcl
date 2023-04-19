globals {
  external_dns_config = {
    app           = {}
    namespace     = null
    repository    = null
    values        = {}
    set           = []
    set_sensitive = []
  }
}

generate_hcl "_terramate_generated_helm_external_dns.tf" {
  content {
    locals {
      values = {
        provider = "google"
        google = {
          project = global.project
        }
        txtOwnerId = "${global.cluster_name}.${global.location}"
        serviceAccount = {
          annotations = {
            "iam.gke.io/gcp-service-account" = google_service_account.external_dns.email
          }
        }
      }
    }

    resource "google_service_account" "external_dns" {
      account_id   = replace(substr("${global.cluster_name}-external-dns", 0, 30), "/[^a-z0-9]$/", "")
      display_name = substr("ExternalDNS service account for k8s cluster: ${global.cluster_name}", 0, 100)
    }

    resource "google_project_iam_member" "external_dns_admin" {
      role    = "roles/dns.admin"
      member  = "serviceAccount:${google_service_account.external_dns.email}"
      project = global.project
    }

    resource "google_service_account_iam_member" "external_dns_workload_identity_user" {
      service_account_id = google_service_account.external_dns.name
      role               = "roles/iam.workloadIdentityUser"
      member             = "serviceAccount:${kubernetes_config_map.gke_data.data.identity_namespace}[external-dns/external-dns]"
    }

    data "kubernetes_config_map" "gke_data" {
      metadata {
        name      = global.gke_data_config_map_name
        namespace = global.k8s_data_sharing_namespace
      }
    }

    module "external_dns" {
      source = "${terramate.stack.path.to_root}/terramate/modules/helm/external-dns"

      app           = global.external_dns_config.app
      namespace     = global.external_dns_config.namespace
      repository    = global.external_dns_config.repository
      values        = [yamlencode(global.external_dns_config.values), yamlencode(local.values)]
      set           = global.external_dns_config.set
      set_sensitive = global.external_dns_config.set_sensitive
    }

    output "chart" {
      value = module.external_dns.chart
    }
  }
}
