# Creates Azure Container Registery
resource "azurerm_container_registry" "registery" {
   name                        = "${var.region_prefix}clusteracr"
   resource_group_name         = azurerm_resource_group.cluster_acr_rg.name
   location                    = azurerm_resource_group.cluster_acr_rg.location
   sku                         = "Standard"    
}

# Sets Role assignment for Azure Container Registry
resource "azurerm_role_assignment" "acr_role_registry" {
  scope                = azurerm_container_registry.registery.id
  role_definition_name = "AcrPull"
  principal_id         = azuread_service_principal.service_principal.object_id
}