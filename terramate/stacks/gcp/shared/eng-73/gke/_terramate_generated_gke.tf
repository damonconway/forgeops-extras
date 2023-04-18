// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

locals {
  cluster_resource_labels = {}
  common_labels = {
    billing_entity  = "engineering"
    employee        = "true"
    es_businessunit = "engineering"
    es_managedby    = "forgeops"
    es_ownedby      = "forgeops"
    es_useremail    = "damon_conway"
    es_zone         = "dev"
  }
  k8s_data_sharing_namespace = "terramate-data"
}
module "gke" {
  cluster_autoscaling = {
    auto_repair         = true
    auto_upgrade        = true
    autoscaling_profile = "BALANCED"
    enabled             = true
    gpu_resources = [
    ]
    max_cpu_cores = 10000
    max_memory_gb = 100000
    min_cpu_cores = 1
    min_memory_gb = 1
  }
  cluster_resource_labels         = merge(local.common_labels, local.cluster_resource_labels)
  description                     = "eng-73-shared"
  enable_vertical_pod_autoscaling = false
  filestore_csi_driver            = true
  horizontal_pod_autoscaling      = true
  http_load_balancing             = false
  ip_range_pods                   = null
  ip_range_services               = null
  kubernetes_version              = "latest"
  logging_service                 = "none"
  master_authorized_networks = [
  ]
  monitoring_enable_managed_prometheus = false
  monitoring_service                   = "none"
  name                                 = "eng-73-shared"
  network                              = "default"
  network_policy                       = false
  network_project_id                   = ""
  node_pools = [
    {
      initial_node_count = 0
      max_count          = 0
      min_count          = 0
      name               = "default"
    },
    {
      auto_repair        = true
      auto_upgrade       = true
      disk_size_gb       = 50
      disk_type          = "pd-ssd"
      enable_gcfs        = true
      image_type         = "COS_CONTAINERD"
      initial_node_count = 3
      local_ssd_count    = 0
      machine_type       = "n2-standard-8"
      max_count          = 6
      min_count          = 3
      min_cpu_platform   = ""
      name               = "blue"
      preemptible        = false
    },
    {
      auto_repair        = true
      auto_upgrade       = true
      disk_size_gb       = 50
      disk_type          = "pd-ssd"
      enable_gcfs        = true
      image_type         = "COS_CONTAINERD"
      initial_node_count = 0
      local_ssd_count    = 0
      machine_type       = "n2-standard-8"
      max_count          = 0
      min_count          = 0
      min_cpu_platform   = ""
      name               = "green"
      preemptible        = false
    },
  ]
  node_pools_metadata = {}
  node_pools_oauth_scopes = {
    default = "https://www.googleapis.com/auth/cloud-platform"
  }
  node_pools_tags   = {}
  node_pools_taints = {}
  project_id        = "engineering-devops"
  region            = "us-east1"
  regional          = true
  release_channel   = null
  source            = "terraform-google-modules/kubernetes-engine/google"
  subnetwork        = "default"
  version           = "~> 25.0"
  zones = [
  ]
}
resource "kubernetes_namespace" {
  metadata {
    name = local.k8s_data_sharing_namespace
  }
}
resource "kubernetes_config_map" {
  metadata {
    data = {
      identity_namespace = module.gke.identity_namespace
    }
    name      = "gke-data"
    namespace = local.k8s_data_sharing_namespace
  }
}
output "cluster" {
  value = module.gke
}
