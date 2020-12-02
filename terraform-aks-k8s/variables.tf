variable "region_name" {
  default     = "eastus"
  description = "The location of the resource"
}

variable "region_prefix" {
  default = "eu2"
}

variable "tags" {
  default = {
    Owner      = "Nelly Alfimov"
    OwnerEmail = "nalfimov@varonis.com"
  }
}

#Kubernetes 
variable "vnet_name" {
  default     = "aks-vnet"
  description = "The name of the clusters vnet"
}

variable "cluster_name" {
  default     = "aks02"
  description = "The AKS cluster name"
}




