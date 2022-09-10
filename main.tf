resource "azurerm_resource_group" "apimanagement" {
  name     = "api-management"
  location = "West Europe"
}

resource "azurerm_api_management" "apimanagement" {
  name                = "example-apim"
  location            = azurerm_resource_group.apimanagement.location
  resource_group_name = azurerm_resource_group.apimanagement.name
  publisher_name      = "My Company"
  publisher_email     = "denizberkyurek4@hotmail.com"

  sku_name = "Developer_1"
}

resource "azurerm_api_management_api" "apimanagement" {
  name                = "express-api"
  resource_group_name = azurerm_resource_group.apimanagement.name
  api_management_name = azurerm_api_management.apimanagement.name
  revision            = "1"
  display_name        = "Express API"
  path                = "express"
  protocols           = ["https"]

  import {
    content_format = "swagger-link-json"
    content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
  }
}
