# OpenCost

This is a simple example of deploying OpenCost into your Kubernetes cluster. The install guide is available [here](https://www.opencost.io/docs/install). For simplicity, we can use the bash script provided in this repo to deploy OpenCost.

## Prerequisites

* Connected to a Kubernetes cluster. For Azure, look at the [Azure platform](../azure/README.md) for instructions on how to create and connect to a cluster.
* [Helm](https://helm.sh/) installed

## Setup

1. Clone this repo
2. Run "opencost_build.bash" to deploy OpenCost