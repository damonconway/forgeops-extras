stack {
  name = "External Secrets chart"

  after = [
    "../../gke",
    "../ingress-nginx"
  ]
}
