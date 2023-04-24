// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

locals {
  client_certificate_enc     = base64decode(data.google_container_cluster.cluster.master_auth[0].client_certificate)
  cluster_ca_certificate_enc = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}
data "google_client_config" "provider" {
}
data "google_container_cluster" "cluster" {
  location = "us-east1"
  name     = "cluster1-dev"
}
provider "kubernetes" {
  client_certificate     = local.client_certificate_enc
  client_key             = data.google_container_cluster.cluster.master_auth[0].client_key
  cluster_ca_certificate = local.cluster_ca_certificate_enc
  host                   = "https://${data.google_container_cluster.cluster.endpoint}"
  token                  = data.google_client_config.provider.access_token
  experiments {
    manifest_resource = true
  }
}
provider "helm" {
  kubernetes {
    client_certificate     = local.client_certificate_enc
    client_key             = data.google_container_cluster.cluster.master_auth[0].client_key
    cluster_ca_certificate = local.cluster_ca_certificate_enc
    host                   = "https://${data.google_container_cluster.cluster.endpoint}"
    token                  = data.google_client_config.provider.access_token
  }
}
