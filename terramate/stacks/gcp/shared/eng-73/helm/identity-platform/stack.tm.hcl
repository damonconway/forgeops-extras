stack {
  name = "Secret Agent chart"

  after = [
    "../../gke",
    "../secret-agent",
    "../ds-operator",
    "../ingress-nginx"
  ]
}
