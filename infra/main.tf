terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "administrator_login" {
  description = "The administrator login for the PostgreSQL server."
}

variable "administrator_password" {
  description = "The administrator password for the PostgreSQL server."
}

variable "application_name" {
  description = "The name of the application."
  default = "tl-sap-shipments"
}

resource "azurerm_resource_group" "ksl_sap_shipments" {
  name     = "${var.application_name}-rg"
  location = "northeurope"

  tags = {
    Owner   = "John Doe"
    DueDate = "2023-04-30"
  }
}

resource "azurerm_postgresql_server" "ksl_sap_shipments" {
  name                = "${var.application_name}-pg"
  location            = azurerm_resource_group.ksl_sap_shipments.location
  resource_group_name = azurerm_resource_group.ksl_sap_shipments.name
  version             = "11"
  administrator_login = var.administrator_login
  administrator_login_password = var.administrator_password

  sku_name   = "GP_Gen5_4"

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  tags = {
    Owner   = "John Doe"
    DueDate = "2023-04-30"
  }
}

# PSQL database 
resource "azurerm_postgresql_database" "ksl_sap_shipments" {
  name                = "${var.application_name}-db"
  resource_group_name = azurerm_resource_group.ksl_sap_shipments.name
  server_name         = azurerm_postgresql_server.ksl_sap_shipments.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
