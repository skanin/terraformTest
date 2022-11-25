data "azurerm_client_config" "current" {}

data "azurerm_subnet" "apim" {
  name                 = local.vnet_apim_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_rg_name
}

data "azurerm_subnet" "common" {
  name                 = local.vnet_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_rg_name
}

data "azurerm_app_service_plan" "common" {
  name                = local.app_service_plan_name
  resource_group_name = local.app_service_plan_rg
}

