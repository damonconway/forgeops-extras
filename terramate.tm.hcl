terramate {
  required_version = "~> 0.2.0"
  config {
    git {
      default_branch    = "master"
      check_untracked   = false
      check_uncommitted = false
    }
  }
}
