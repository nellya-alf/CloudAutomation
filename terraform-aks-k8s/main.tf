 terraform {
      backend "remote" {
        organization = var.organization
        workspaces {
          name = var.workspaces
        }
      }
    }


data "azurerm_client_config" "current" {}

# Creates Azure Container Registery resource group
resource "azurerm_resource_group" "cluster_acr_rg"{
  name     = "${var.region_prefix}-clusteracr-rg"
  location = var.region_name
  tags     = var.tags   
}

# Creates a resource group for the AKS cluster
resource "azurerm_resource_group" "cluster_resource_group" {    
    
    name     = "${var.region_prefix}-${var.cluster_name}-rg"
    location = var.region_name
    tags     = var.tags
}

# Creates resource group for MySql server database
# resource "azurerm_resource_group" "database_resource_group" {
#     name      = "${var.region_prefix}-grafanadb-rg"
#     location  = var.region_name
#     tags      = var.tags
# }

# # Creates Azure Key Vault
# resource "azurerm_key_vault" "database_keyvault" {
#   name                        = "${var.region_prefix}-grafanadb-kv"
#   location                    = var.region_name
#   resource_group_name         = azurerm_resource_group.database_resource_group.name
#   enabled_for_disk_encryption = true
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   soft_delete_enabled         = true
#   purge_protection_enabled    = true

#   sku_name = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id
  
#     key_permissions = [
#       "get",
#       "create",
#     ]

#     secret_permissions = [
#       "get",
#       "set",
#       "list",
#       "delete",
#     ]   
#   }

#   tags = var.tags
# }

# # Creates Azure key vault secret
# resource "azurerm_key_vault_secret" "db_admin_secret" {
#   name         = "adminpassword03"
#   value        = random_password.db_password.result
#   key_vault_id = azurerm_key_vault.database_keyvault.id
#   tags         = var.tags
# }

# Creates MySql Server resource 
# resource "azurerm_mysql_server" "mysql_server"{
#   name                = "${var.region_prefix}-grafana-db"
#   location            = var.region_name
#   resource_group_name = azurerm_resource_group.database_resource_group.name

#   sku_name = "B_Gen5_2"

#   storage_profile {
#     storage_mb            = 5120
#     backup_retention_days = 7
#     geo_redundant_backup  = "Disabled"
#   }
  
#   administrator_login          = "mysqladmin"
#   administrator_login_password = azurerm_key_vault_secret.db_admin_secret.value
#   version                      = "5.7"
#   ssl_enforcement              = "Enabled"
# }


# Creates Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "cluster_worksace" {
    name                = "${var.region_prefix}-${var.cluster_name}-ws"
    location            = var.region_name
    resource_group_name = azurerm_resource_group.cluster_resource_group.name
    sku                 = "Standard"
    retention_in_days   = "30"
    tags                = var.tags
}





