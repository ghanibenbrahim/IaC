terraform {
  required_providers {
    flexibleengine = {
      source = "FlexibleEngineCloud/flexibleengine"
      version = "1.36.0"
    }
  }
}


provider "flexibleengine" {
  tenant_id = "tenat_id"
  domain_name = "domain_name"
  access_key = "access_key"
  secret_key  = " secret_key"
  auth_url    = ""
  region      = ""
}


