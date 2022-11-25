# Common
variable "company" {
  type        = string
  description = "Abbreviation of the company owner of these resouces. Has to be lower case. For instance, BKK Nett becomes `bkkn`."

  validation {
    condition     = can(regex("^bkk[a-z]$", var.company)) || var.company == "core" || var.company == "corp"
    error_message = "Company varible does not follow the convention set for this variable. Should be `bkk<one letter>` or `core` or `corp`."
  }
}
variable "environment" {
  type        = string
  description = "Name of the runtime environment (prod/test/dev)."

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Allowed environments are dev, test, prod."
  }
}
variable "env_instance_number" {
  type        = string
  description = "Two-digit instance number of the runtime environment (01, 02, etc.)."

  validation {
    condition     = length(var.env_instance_number) == 2 && can(parseint(var.env_instance_number, 10))
    error_message = "Must be number with two digits."
  }
}
variable "application_name" {
  type        = string
  description = "Name of the application, i.e. someapi"
}

# Resource groups
variable "tags" {
  type        = map(string)
  description = " Tags for the resources"
}
variable "location" {
  type        = string
  description = " Location of resource groups containing resources related to APIM"
  default     = "Norway East"
}

variable "log_retention_days" {
  type        = number
  description = "The number of days the API should keep access logs."
  default     = 60
}

locals {
  # vNet integration
  vnet_name                = format("%s-%s-%s-apim-vnet", var.company, local.environment_letter, var.env_instance_number)
  vnet_subnet_name         = format("%s-%s-%s-apps-snet", var.company, local.environment_letter, var.env_instance_number)
  vnet_apim_subnet_name    = format("%s-%s-%s-apim-snet", var.company, local.environment_letter, var.env_instance_number)
  vnet_intapps_subnet_name = format("%s-%s-%s-intapps-snet", var.company, local.environment_letter, var.env_instance_number)
  vnet_rg_name             = format("AZ-%s-%s-%s-APIM-Networking-rg", upper(var.company), var.env_instance_number, upper(local.environment_letter))

  # Shared app service plan
  app_service_plan_name = format("%s-%s-%s-apis-plan", var.company, local.environment_letter, var.env_instance_number)
  app_service_plan_rg   = format("AZ-%s-%s-%s-APIM-Apis-rg", upper(var.company), var.env_instance_number, upper(local.environment_letter))
  app_name_prefix       = format("%s-%s-%s-%s", var.company, local.environment_letter, var.env_instance_number, var.application_name)

  # Outage
  func_rg_name = format("AZ-%s-%s-%s-FUNC-%s-rg", upper(var.company), var.env_instance_number, upper(local.environment_letter), var.application_name)

  key_vault_ref = "@Microsoft.KeyVault(SecretUri=%ssecrets/%s/)"
}

locals {
  environment_letter = lower(substr(var.environment, 0, 1))
}
