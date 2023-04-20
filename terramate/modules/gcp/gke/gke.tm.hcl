# This file is part of Terramate Configuration.
# Terramate is an orchestrator and code generator for Terraform.
# Please see https://github.com/mineiros-io/terramate for more information.
#
# To generate/update Terraform code within the stacks
# run `terramate generate` from root directory of the repository.

globals {
  gke_config = {
    module_version                       = "~> 25.0"
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
}

generate_hcl "_terramate_generated_gke.tf" {
  content {
    locals {
      common_labels              = global.common_labels
      cluster_resource_labels    = global.gke_config.cluster_resource_labels
      k8s_data_sharing_namespace = global.k8s_data_sharing_namespace
    }

    module "gke" {
      source  = "terraform-google-modules/kubernetes-engine/google"
      version = global.gke_config.module_version

      project_id                           = global.gke_config.project_id
      name                                 = global.gke_config.name
      description                          = global.gke_config.description
      regional                             = global.gke_config.regional
      region                               = global.gke_config.region
      zones                                = global.gke_config.zones
      network                              = global.gke_config.network
      network_project_id                   = global.gke_config.network_project_id
      subnetwork                           = global.gke_config.subnetwork
      kubernetes_version                   = global.gke_config.kubernetes_version
      master_authorized_networks           = global.gke_config.master_authorized_networks
      enable_vertical_pod_autoscaling      = global.gke_config.enable_vertical_pod_autoscaling
      horizontal_pod_autoscaling           = global.gke_config.horizontal_pod_autoscaling
      ip_range_pods                        = global.gke_config.ip_range_pods
      ip_range_services                    = global.gke_config.ip_range_services
      http_load_balancing                  = global.gke_config.http_load_balancing
      network_policy                       = global.gke_config.network_policy
      filestore_csi_driver                 = global.gke_config.filestore_csi_driver
      monitoring_enable_managed_prometheus = global.gke_config.monitoring_enable_managed_prometheus
      monitoring_service                   = global.gke_config.monitoring_service
      logging_service                      = global.gke_config.logging_service
      release_channel                      = global.gke_config.release_channel
      cluster_resource_labels              = merge(local.common_labels, local.cluster_resource_labels)
      cluster_autoscaling                  = global.gke_config.cluster_autoscaling
      node_pools                           = global.gke_config.node_pools
      node_pools_oauth_scopes              = global.gke_config.node_pools_oauth_scopes
      node_pools_metadata                  = global.gke_config.node_pools_metadata
      node_pools_taints                    = global.gke_config.node_pools_taints
      node_pools_tags                      = global.gke_config.node_pools_tags
    }

    resource "kubernetes_namespace" "ns" {
      metadata {
        name = local.k8s_data_sharing_namespace
      }
    }

    resource "kubernetes_config_map" "config" {
      metadata {
        name      = global.gke_data_config_map_name
        namespace = local.k8s_data_sharing_namespace

        data = {
          identity_namespace = module.gke.identity_namespace
        }
      }
    }

    output "cluster" {
      value = module.gke
    }
  }
}
