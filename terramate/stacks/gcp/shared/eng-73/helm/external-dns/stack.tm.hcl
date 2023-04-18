stack {
  id          = "eng-73-shared_external-dns"
  description = "Metrics Server"

  after = [
    "/terramate/stacks/gcp/shared/eng-73/gke"
  ]
}
