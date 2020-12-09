terraform {
  required_providers {
    azurerm = "= 2.0.0"
  }
}


provider "azurerm" {

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}

provider "azuread" {

}

provider "kubernetes" {
  load_config_file       = false
  host                   = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.host
  username               = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.username
  password               = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.password
  client_certificate     = "${base64decode(azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.cluster_ca_certificate)}"
}

# Run helm release
provider "helm" {

}
