stack {
  id          = "eng-73-shared_nginx"
  description = "Nginx ingress controller"

  after = [
    "/terramate/stacks/gcp/shared/eng-73/gke"
  ]
}
