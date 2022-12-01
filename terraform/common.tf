data "azurerm_client_config" "current" {}

data "azurerm_app_service_plan" "common" {
  name                = local.app_service_plan_name
  resource_group_name = local.app_service_plan_rg
}