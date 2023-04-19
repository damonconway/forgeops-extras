variable "app" {
  description = "Map of settings to pass to release/helm module"
  type        = map(any)
  default     = {}
}

variable "namespace" {
  description = "Name of the k8s namespace to deploy into"
  type        = string
  default     = "cert-manager"
}

variable "repository" {
  description = "Repository URL"
  type        = string
  default     = "https://charts.jetstack.io"
}

variable "set" {
  description = "List of map(string) of set blocks to create"
  type        = list(map(string))
  default     = []
}

variable "set_sensitive" {
  description = "List of map(string) of set_sensitive blocks to create"
  type        = list(map(string))
  default     = []
}

variable "values" {
  description = "List of values in raw yaml to pass to helm"
  type        = list(string)
  default     = []
}
