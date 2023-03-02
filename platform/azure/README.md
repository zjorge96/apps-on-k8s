# Build a Kubernetes Cluster on Azure Using Terraform

This repo contains a Terraform file that can be used to build a quick and clean Kubernetes cluster on Azure. It is based on the [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/) and uses [Terraform](https://www.terraform.io/) to build the cluster.

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [Terraform](https://www.terraform.io/downloads.html)

## Setup

1. Clone this repo
2. Run `az login` to login to Azure
3. Check the "main.tf" file and update the local variables to your liking
4. Run `terraform init` to initialize Terraform
5. Run `terraform plan` to see what will be created
6. Run `terraform apply` to create the cluster
7. Connect to the cluster using `az aks get-credentials --resource-group <resource-group-name> --name <cluster-name>`

## Destroy

1. Run `terraform destroy` to destroy the cluster