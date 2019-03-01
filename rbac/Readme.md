## Create Dashboard Account
[RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) prevents the default AKS Dashboard account from accessing Kubernetes resources therefore a new service account should be created to view the Kubernetes Dashboard.

Step 1 - Run the script [create-dashboord-account.sh](https://github.com/cloudpea/Kubernetes/blob/master/rbac/create-dashboard-account.sh)  
Step 2 - Copy Token Output from the script and save in a secure location.  
Step 3 - Run the command - kubectl proxy  
Step 4 - Access the dashboard at via Token Authentication - http://localhost:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/#!/login
