terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Change out these local variables to alter the cluster, resource group, and tag owner names
locals {
  owner        = "zach"
  cluster_name = "grafana"
}

resource "azurerm_resource_group" "cluster" {
  name     = "${local.owner}-${local.cluster_name}-rg"
  location = "westus2"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${local.owner}-${local.cluster_name}-cluster"
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  dns_prefix          = "${local.owner}${local.cluster_name}cluster"

  default_node_pool {
    name                = "default"
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 5
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  tags = {
    "Owner" = "${local.owner}"
  }
}

# Get the credentials for the cluster
# az aks get-credentials --resource-group zach-opencost-rg --name zach-opencost-cluster