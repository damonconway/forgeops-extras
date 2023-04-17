globals {
  # ForgeRock employees should set these in stacks/config.tm.hcl
  # Everyone else may modify this map with the labels you need. This includes
  # setting it to an empty map.
  common_labels = {
    employee        = "false"
    billing_entity  = ""
    es_useremail    = ""
    es_businessunit = ""
    es_ownedby      = ""
    es_managedby    = ""
    es_zone         = ""
  }
}
