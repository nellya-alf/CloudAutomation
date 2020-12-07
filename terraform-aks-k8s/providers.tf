provider "azurerm" {
   version = "=2.0.0"
   features {}
}

provider "azuread" {
    
}

provider "kubernetes"{
  load_config_file = false
  insecure         = true 
  host                   = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.host
  username               = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.username
  password               = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.password
} 


provider "helm"{
 
}
