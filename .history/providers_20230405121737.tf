terraform {
  required_providers {
    flexibleengine = {
      source = "FlexibleEngineCloud/flexibleengine"
      version = "1.36.0"
    }
  }
}


provider "flexibleengine" {
  tenant_id = "7664ed44f8264e63b00024d34173b5c2"
  domain_name = "OCB0003815"
  access_key = "HNY2IZGXQPWKZJM160I5"
  secret_key  = " 0XxqUJ1AlczPML2rvRPkeYlQMiABpKXMRQF9WAR6"
  auth_url    = "https://iam.eu-west-0.prod-cloud-ocb.orange-business.com:443/v3"
  region      = "eu-west-0"
}


