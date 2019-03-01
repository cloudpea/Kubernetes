#!/bin/bash
read -p "Enter Subscription ID: " subscriptionId
read -p "Enter AKS ResourceGroup Name: " resourceGroup
read -p "Enter AKS Cluster Name: " clusterName
az login
az account set --subscription $subscriptionId
az aks get-credentials --resource-group $resourceGroup --name $clusterName
kubectl apply -f ./infrastructure/kubernetes/helm/helm-rbac.yaml
helm init --upgrade --service-account tiller
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/