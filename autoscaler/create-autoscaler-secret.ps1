# PowerShell Script to Create Cluster-AutoScaler Secret for AKS
Param (
  [Parameter(Mandatory=$True)]
  [string]$SUBSCRIPTION_ID,

  [Parameter(Mandatory=$True)]
  [string]$CLUSTER_NAME,

  [Parameter(Mandatory=$True)]
  [string]$RESOURCE_GROUP
)

# Login to Azure and Select Subscription
az login
az account set --subscription $SUBSCRIPTION_ID

# Get Node Resource Group
$NODE_RESOURCE_GROUP=$(az aks show --name $CLUSTER_NAME  --resource-group $RESOURCE_GROUP -o tsv --query 'nodeResourceGroup')

# Create Azure AD Service Principal
$PERMISSIONS=$(az ad sp create-for-rbac -n ("https://"+$CLUSTER_NAME+"-AUTOSCALER") --role="Contributor" `
--scopes /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP  `
/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$NODE_RESOURCE_GROUP -o json)

# Convert from JSON and get values.
$PERMISSIONS = $PERMISSIONS | ConvertFrom-Json
$CLIENT_ID= $PERMISSIONS.appId
$CLIENT_SECRET= $PERMISSIONS.password
$TENANT_ID= $PERMISSIONS.tenant

# Convert to Base64 Encoded Values
$CLUSTER_NAME = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($CLUSTER_NAME))
$RESOURCE_GROUP = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($RESOURCE_GROUP))
$SUBSCRIPTION_ID = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($SUBSCRIPTION_ID))


$CLIENT_ID = [System.Text.Encoding]::UTF8.GetBytes($CLIENT_ID)
$CLIENT_ID =[Convert]::ToBase64String($CLIENT_ID)

$CLIENT_SECRET = [System.Text.Encoding]::UTF8.GetBytes($CLIENT_SECRET)
$CLIENT_SECRET =[Convert]::ToBase64String($CLIENT_SECRET)

$TENANT_ID = [System.Text.Encoding]::UTF8.GetBytes($TENANT_ID)
$TENANT_ID =[Convert]::ToBase64String($TENANT_ID)

$NODE_RESOURCE_GROUP = [System.Text.Encoding]::UTF8.GetBytes($NODE_RESOURCE_GROUP)
$NODE_RESOURCE_GROUP =[Convert]::ToBase64String($NODE_RESOURCE_GROUP)


# Write Output for Kubernetes Secret in YAML Format
Write-Output "---
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