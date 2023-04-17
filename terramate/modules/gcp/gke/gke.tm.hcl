# This file is part of Terramate Configuration.
# Terramate is an orchestrator and code generator for Terraform.
# Please see https://github.com/mineiros-io/terramate for more information.
#
# To generate/update Terraform code within the stacks
# run `terramate generate` from root directory of the repository.

# This file is defined on a very high level to simulate code deduplication between
# different environments. The same code will be used in staging and production
# triggered by /stacks/{environment}/service-accounts/use_service_account.tm.hcl

globals {
  module_version = "~> 25.0"

  project_id                           = global.project
  name                                 = global.cluster_name
  description                          = global.cluster_name
  region                               = global.location
  regional                             = true
  zones                                = []
  network                              = "default"
  network_project_id                   = ""
  network_policy                       = false
  subnetwork                           = "default"
  kubernetes_version                   = "latest"
  master_authorized_networks           = []
  enable_vertical_pod_autoscaling      = false
  horizontal_pod_autoscaling           = true
  ip_range_pods                        = null
  ip_range_services                    = null
  http_load_balancing                  = false
  cluster_resource_labels              = {}
  namespace                            = ""
  filestore_csi_driver                 = true
  monitoring_enable_managed_prometheus = false
  monitoring_service                   = "none"
  logging_service                      = "none"
  release_channel                      = null

  cluster_autoscaling = {
    enabled             = true
    max_cpu_cores       = 10000
    min_cpu_cores       = 1
    max_memory_gb       = 100000
    min_memory_gb       = 1
    gpu_resources       = []
    auto_repair         = true
    auto_upgrade        = true
    autoscaling_profile = "BALANCED"
  }

  node_pools = [
    {
      name               = "default"
      machine_type       = "n2-standard-8"
      initial_node_count = 3
      min_count          = 3
      max_count          = 6
      local_ssd_count    = 0
      disk_size_gb       = 50
      disk_type          = "pd-ssd"
      image_type         = "COS_CONTAINERD"
      min_cpu_platform   = ""
      enable_gcfs        = true # AKA image streaming
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
    }
  ]

  node_pools_oauth_scopes = {
    default = "https://www.googleapis.com/auth/cloud-platform"
  }
  node_pools_labels   = {}
  node_pools_metadata = {}
  node_pools_taints   = {}
  node_pools_tags     = {}
}

generate_hcl "_terramate_generated_gke.tf" {
  content {
    locals {
      common_labels           = global.common_labels
      cluster_resource_labels = global.cluster_resource_labels
    }

    module "gke" {
      source  = "terraform-google-modules/kubernetes-engine/google"
      version = global.module_version

      project_id                           = global.project_id
      name                                 = global.name
      description                          = global.description
      regional                             = global.regional
      region                               = global.region
      zones                                = global.zones
      network                              = global.network
      network_project_id                   = global.network_project_id
      subnetwork                           = global.subnetwork
      kubernetes_version                   = global.kubernetes_version
      master_authorized_networks           = global.master_authorized_networks
      enable_vertical_pod_autoscaling      = global.enable_vertical_pod_autoscaling
      horizontal_pod_autoscaling           = global.horizontal_pod_autoscaling
      ip_range_pods                        = global.ip_range_pods
      ip_range_services                    = global.ip_range_services
      http_load_balancing                  = global.http_load_balancing
      network_policy                       = global.network_policy
      filestore_csi_driver                 = global.filestore_csi_driver
      monitoring_enable_managed_prometheus = global.monitoring_enable_managed_prometheus
      monitoring_service                   = global.monitoring_service
      logging_service                      = global.logging_service
      release_channel                      = global.release_channel
      cluster_resource_labels              = merge(local.common_labels, local.cluster_resource_labels)
      cluster_autoscaling                  = global.cluster_autoscaling
      node_pools                           = global.node_pools
      node_pools_oauth_scopes              = global.node_pools_oauth_scopes
      node_pools_metadata                  = global.node_pools_metadata
      node_pools_taints                    = global.node_pools_taints
      node_pools_tags                      = global.node_pools_tags
    }

    output "cluster" {
      value = module.gke
    }
  }
}
