globals {
  terraform_version = "~> 1.0"

  # ForgeRock employees should set these
  # Everyone else may modify this map with the labels you need. This includes
  # setting
  common_labels = {
    employee        = "true"
    billing_entity  = "engineering"
    es_useremail    = "damon_conway"
    es_businessunit = "engineering"
    es_ownedby      = "forgeops"
    es_managedby    = "forgeops"
    es_zone         = "dev"
  }
}
