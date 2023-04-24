stack {
  name = "Nginx Ingress chart"

  after = [
    "../../gke"
  ]
}
