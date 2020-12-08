# Creates virtual network for the cluster
resource "azurerm_virtual_network" "cluster_vnet" {
  name                = "${var.cluster_name}-vnet"
  location            = var.region_name
  resource_group_name = azurerm_resource_group.cluster_resource_group.name
  address_space       = ["10.0.0.0/8"]
  tags                = var.tags
}

# Creates Subnet for cluster
resource "azurerm_subnet" "cluster_subnet" {
  name                 = "${var.cluster_name}-subnet"
  resource_group_name  = azurerm_resource_group.cluster_resource_group.name
  address_prefix       = "10.240.0.0/16"
  virtual_network_name = azurerm_virtual_network.cluster_vnet.name
}

# Creates AKS Cluster
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {

  name                = "${var.region_prefix}-${var.cluster_name}-cluster"
  location            = var.region_name
  resource_group_name = azurerm_resource_group.cluster_resource_group.name
  dns_prefix          = "${var.cluster_name}dns"

  default_node_pool {
    name           = "default"
    node_count     = 2
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.cluster_subnet.id
  }

  service_principal {
    client_id     = azuread_service_principal.service_principal.application_id
    client_secret = random_password.password.result
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.cluster_worksace.id
    }
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.2.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.2.0.0/24"
  }
}


