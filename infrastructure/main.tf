provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.60"
    }
  }
  backend "azurerm" {
    container_name = "tofu-MyTestFunction-api"
    key            = "tf-infrastructure-deployment.tfstate"
  }
}

module "outage_module" {
  source                     = "git@github.com:bkkas/azure-function-module.git"
  company                    = var.company
  environment                = var.environment
  env_instance_number        = var.env_instance_number
  application_name           = var.application_name
  location                   = var.location

  tags = {
    CostCenter : "Teknologi og fornyelse",
    Department : "Teknologi og fornyelse",
    Owner : "olav.lokkebo@eviny.no"
    IsAutomated : "true",
    MaintainedBy : "terraform"
  }
}