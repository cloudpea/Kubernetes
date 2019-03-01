## Deployment 3 - Deploy Certificate Manager
[CertManager](https://github.com/jetstack/cert-manager) is used to automatically provision and renew TLS certificates in your Kubernetes Cluster with LetsEncrypt.

Step 1 - Install Cert Manger via the Helm command:  
helm install stable/cert-manager --name cert-manager --namespace kube-system  

Step 2 - Update [cluster-issuer.yaml](https://github.com/cloudpea/Kubernetes/blob/master/cert-manager/cluster-issuer.yaml) with a valid email address.  

Step 3 - Provision the Cluster Certificate Issuer or Namespace Certificate Issuer depending on the scope you want the issuer to provision certificates for:  
kubectl apply -f cluster-issuer.yaml  
kubectl apply -f issuer.yaml  

Step 4 - See [ingress-rules.yaml](https://github.com/cloudpea/Kubernetes/blob/master/networking/ingress-rules.yaml) for example configuration to allow automatic provisioning of TLS certificates.