globals {
  terraform_google_provider_project = "engineering-devops"
  terraform_google_provider_region  = "us-east1"
  terraform_google_provider_version = "~> 4.0"

  project  = global.terraform_google_provider_project
  location = global.terraform_google_provider_region

  gke_data_config_map_name = "gke-data"
}
