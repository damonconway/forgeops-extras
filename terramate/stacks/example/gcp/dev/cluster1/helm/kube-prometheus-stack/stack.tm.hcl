stack {
  name = "Kube Prometheus Stack chart"

  after = [
    "../../gke"
  ]
}
