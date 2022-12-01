output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "funcapp_name" {
  value = azurerm_function_app.az_func.name
}