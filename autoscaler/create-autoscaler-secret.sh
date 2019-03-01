#! /bin/bash
read -p "What's your subscription id? " SUBSCRIPTION_ID
read -p "What's your cluster name? " CLUSTER_NAME
read -p "Resource group name? " RESOURCE_GROUP

az login
az account set --subscription $SUBSCRIPTION_ID

CLUSTER_NAME=`echo $CLUSTER_NAME | base64`
RESOURCE_GROUP=`echo $RESOURCE_GROUP | base64`
NODE_RESOURCE_GROUP=`az aks show --name $CLUSTER_NAME  --resource-group $RESOURCE_GROUP -o tsv --query 'nodeResourceGroup' | base64`

az ad sp create-for-rbac -n ("https://"+$CLUSTER_NAME+"-AUTOSCALER") --role="Contributor" `
--scopes /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP  `
/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$NODE_RESOURCE_GROUP -o json

TENANT_ID=`echo $PERMISSIONS | sed -e 's/^.*"tenant"[ ]*:[ ]*"//' -e 's/".*//' | base64`
CLIENT_ID=`echo $PERMISSIONS | sed -e 's/^.*"appId"[ ]*:[ ]*"//' -e 's/".*//' | base64`
CLIENT_SECRET=`echo $PERMISSIONS | sed -e 's/^.*"password"[ ]*:[ ]*"//' -e 's/".*//' | base64`
SUBSCRIPTION_ID=`echo $SUBSCRIPTION_ID | base64`


echo "---
apiVersion: v1
kind: Secret
metadata:
    name: cluster-autoscaler-azure
    namespace: kube-system
data:
    ClientID: $CLIENT_ID
    ClientSecret: $CLIENT_SECRET
    ResourceGroup: $RESOURCE_GROUP
    SubscriptionID: $SUBSCRIPTION_ID
    TenantID: $TENANT_ID
    VMType: QUtTCg==
    ClusterName: $CLUSTER_NAME
    NodeResourceGroup: $NODE_RESOURCE_GROUP
---"