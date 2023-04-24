globals "gke_config" {
  kubernetes_version = "1.25"

  node_pools = [
    {
      name               = "default"
      initial_node_count = 0
      min_count          = 0
      max_count          = 0
    },
    {
      # Machine Type sizing starting points
      # Pick your type based on your performance needs
      # n2-standard-8 for small clusters
      # c2-standard-30 for medium and large clusters
      #
      # Adjust the counts based on your performance needs.
      name               = "blue"
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
    },
    {
      name               = "green"
      machine_type       = "n2-standard-8"
      initial_node_count = 0
      min_count          = 0
      max_count          = 0
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
    blue  = ["https://www.googleapis.com/auth/cloud-platform"]
    green = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
