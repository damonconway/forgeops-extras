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
      }
    }
  }
}
