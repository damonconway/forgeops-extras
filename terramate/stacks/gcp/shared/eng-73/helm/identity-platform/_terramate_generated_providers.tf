// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

provider "google" {
  project = "engineering-devops"
  region  = "us-east1"
}
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.16"
    }
  }
}
