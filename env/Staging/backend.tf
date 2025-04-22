terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatevule04222025"
    container_name       = "tfstate"
    key                  = "staging.terraform.tfstate"
  }
}

