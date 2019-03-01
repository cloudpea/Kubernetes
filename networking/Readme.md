## Deploy Kube-Router & Network Policies
[Kube-Router](https://github.com/cloudnativelabs/kube-router) has a number of useful feartures within Kubernetes Networking, the primary reason for using Kube-Router myself is the Network Policy Controller to enforce Network Security via Policies.

Step 1 - Provision Kube Router with the below command:  
kubectl apply -f kube-router.deploy.yaml  

Step 2 - Provision Network Policies with the below command  
kubectl apply -f network-policies.yaml


## Deploy Ingress Controller & Rules
[External-Ingress](https://github.com/kubernetes/ingress-nginx) is used to route traffic from the internet via an External Azure Load Balancer to the relevant Kubernetes Microservices running inside the Cluster.

Step 1 - Provision External Ingress Controller via Helm with the command:  
helm install stable/nginx-ingress --name ext-nginx-ingress --namespace kube-system \  
--set rbac.create=true \  
--set controller.replicaCount=2  


[Internal-Ingress](https://docs.microsoft.com/en-us/azure/aks/internal-lb) is used to route traffic from within the Azure vNet via an Internal Azure Load Balancer to the relevant Kubernetes Microservices running inside the Cluster.

Step 1 - Add permissions for the AKS Service Principal to the AKS Node Subnet with the Network Contributor role.  
Step 2 - Provision External Ingress Controller via Helm with the command:  
helm install stable/nginx-ingress --name int-ingress-controller --namespace kube-system \  
--set rbac.create=true \  
--set controller.replicaCount=2 \  
-f internal-loadbalancer.yaml