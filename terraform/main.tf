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

resource "azurerm_resource_group" "rg" {
  name     = "terraform-rg"
  location = "Norway East"
}

resource "azurerm_storage_account" "func-app-st" {
  name                     = "terraformfuncappst"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_function_app" "az_func" {
  name                       = format("%s-func", local.app_name_prefix)
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = data.azurerm_app_service_plan.common.id
  storage_account_name       = azurerm_storage_account.func-app-st.name
  storage_account_access_key = azurerm_storage_account.func-app-st.primary_access_key
  https_only                 = true
  enable_builtin_logging     = false
  version                    = "~4"
}