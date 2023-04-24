generate_hcl "_terramate_generated_providers.tf" {
  content {
    provider "google" {
      project = global.terraform_google_provider_project
      region  = global.terraform_google_provider_region
    }

    terraform {
      required_providers {
        google = {
          source  = "hashicorp/google"
          version = global.terraform_google_provider_version
        }

        helm = {
          source  = "hashicorp/helm"
          version = global.terraform_helm_provider_version
        }

        kubernetes = {
          source  = "hashicorp/kubernetes"
          version = global.terraform_kubernetes_provider_version
        }
      }
    }
  }
}
