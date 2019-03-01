# PowerShell Script to create a Read Only Dashboard Account in an AKS Cluster
Param (
  [Parameter(Mandatory=$True)]
  [string]$subscriptionId,

  [Parameter(Mandatory=$True)]
  [string]$resourceGroup,

  [Parameter(Mandatory=$True)]
  [string]$clusterName
)
az login
az account set --subscription $subscriptionId
az aks get-credentials --resource-group $resourceGroup --name $clusterName
kubectl apply -f ./infrastructure/kubernetes/helm/helm-rbac.yaml
helm init --upgrade --service-account tiller
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/