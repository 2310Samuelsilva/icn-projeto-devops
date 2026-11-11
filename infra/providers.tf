# Which Terraform version and which provider (plugin) to use.
# The azurerm provider is what talks to the Azure API.

terraform {
  required_version = ">= 1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Remote state: Terraform's record of what it built lives in Azure Storage,
  # shared by your Mac and the pipeline. The storage account name is unique per
  # person, so it is passed at init time:
  #   terraform init -backend-config="storage_account_name=<name>"
  backend "azurerm" {
    resource_group_name = "icn-devops-tfstate-rg"
    container_name      = "tfstate"
    key                 = "demo.tfstate"
  }
}

# Subscription comes from the ARM_SUBSCRIPTION_ID environment variable.
provider "azurerm" {
  features {}
  resource_provider_registrations = "core"
}
