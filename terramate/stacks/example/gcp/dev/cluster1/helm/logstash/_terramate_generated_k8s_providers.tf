// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "google_client_config" "provider" {
}
data "google_container_cluster" "cluster" {
  location = "us-east1"
  name     = "eng-73-shared"
}
provider "kubernetes" {
  client_certificate     = base64decode(data.google_container_cluster.master_auth[0].cluster_client_certificate)
  client_key             = data.google_container_cluster.cluster.master_auth[0].client_key
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
  host                   = "https://${data.google_container_cluster.cluster.endpoint}"
  token                  = data.google_client_config.provider.access_token
  experiments {
    manifest_resource = true
  }
}
provider "helm" {
  kubernetes = {
    host                   = "https://${data.google_container_cluster.cluster.endpoint}"
    cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
    client_certificate     = base64decode(data.google_container_cluster.master_auth[0].cluster_client_certificate)
    client_key             = data.google_container_cluster.cluster.master_auth[0].client_key
    token                  = data.google_client_config.provider.access_token
  }
}
