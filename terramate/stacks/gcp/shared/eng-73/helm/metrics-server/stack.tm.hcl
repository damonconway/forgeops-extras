stack {
  id          = "eng-73-shared_metrics-server"
  description = "Metrics Server"

  after = [
    "/terramate/stacks/gcp/shared/eng-73/gke"
  ]
}
