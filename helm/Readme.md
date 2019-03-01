## Helm Install
[Helm](https://helm.sh/) is a package manager for Kubernetes, and a Helm Chart has been created to deploy a number of resources. This means you can deploy Applications with a single command.

Step 1 - Install the Helm binary following the instructions at - https://github.com/helm/helm  

Step 2 - Run the [configure-helm.sh](https://github.com/cloudpea/Kubernetes/blob/master/helm/configure-helm.sh) script for Linux or the [configure-helm.ps1](https://github.com/cloudpea/Kubernetes/blob/master/helm/configure-helm.ps1) script for Windows to initialise helm with a Kubernetes Service Account and add the required helm repos.