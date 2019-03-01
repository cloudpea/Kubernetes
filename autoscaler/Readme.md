## Deploy Cluster-Autoscaler
[Cluster-Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler) is used to dynamically scale Kubernetes Worker Nodes based on resource consumption and pod resource allocation.

Step 1 - Run the [create-autoscaler-secret.sh](https://github.com/cloudpea/Kubernetes/blob/master/autoscaler/create-autoscaler-secret.sh) script for Linux or the [create-autoscaler-secret.ps1](https://github.com/cloudpea/Kubernetes/blob/master/autoscaler/create-autoscaler-secret.ps1) script for Windows and copy the output.  

Step 2 - Paste the output in to the Secret section within [aks-cluster-autoscaler.yaml](https://github.com/cloudpea/Kubernetes/blob/master/autoscaler/aks-cluster-autoscaler.yaml])  

Step 3 - Update the below section of [aks-cluster-autoscaler.yaml](https://github.com/cloudpea/Kubernetes/blob/master/autoscaler/aks-cluster-autoscaler.yaml]):  
Syntax:-  
--nodes=min_nodes:max_nodes:node_pool_name  
Example:-  
--nodes=3:10:agentpool  

Step 4 - Provision Cluster Autoscaler with the below command:  
kubectl apply -f aks-cluster-autoscaler.yaml