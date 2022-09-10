# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_api_management_api" "expressapi" {
   name                = "express-api"
   resource_group_name = "api-management"
   api_management_name = "azure-api-mgmt"
   revision            = "3"
   display_name        = "Express API"
   path                = "express"
   protocols           = ["https"]

   import {
     content_format = "swagger-link-json"
     content_value  = "https://raw.githubusercontent.com/dnzbrkyrk/azure-web-app-today/master/Api/azure-web-app-today.swagger.json"
   }
}

data "azurerm_api_management_api" "expressapi" {
  name                = "express-api"
  resource_group_name = "api-management"
  api_management_name = "azure-api-mgmt"
  revision            = "2"
}

data "azurerm_api_management_api" "expressapiexisting" {
  name                = "express-api"
  api_management_name = "azure-api-mgmt"
  resource_group_name = "api-management"
}

output "api_management_api_id" {
  value = data.azurerm_api_management_api.expressapi.id
}


