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
}

# Subscription comes from the ARM_SUBSCRIPTION_ID environment variable.
provider "azurerm" {
  features {}
  resource_provider_registrations = "core"
}
