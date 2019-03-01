# PowerShell Script to Configure Helm on an AKS Cluster
Param (
  [Parameter(Mandatory=$True)]
  [string]$dashboardUsername
)
kubectl create serviceaccount $dashboardUsername -n kube-system
kubectl create clusterrolebinding $dashboardUsername -n kube-system --clusterrole=view --serviceaccount=kube-system:$dashboardUsername
kubectl get secret -n kube-system $(kubectl get serviceaccount $dashboardUsername -n kube-system -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
Write-Host " "
Write-Host "Please save the username and above authentication key in Secret Server."