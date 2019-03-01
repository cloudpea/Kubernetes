## Deployment 3 - Deploy Certificate Manager
[CertManager](https://github.com/jetstack/cert-manager) is used to automatically provision and renew TLS certificates in your Kubernetes Cluster with LetsEncrypt.

Step 1 - Update the [cluster-issuer.yaml](https://github.com/cloudpea/Kubernetes/blob/master/cert-manager/cluster-issuer.yaml) & [certificates.yaml](https://github.com/cloudpea/Kubernetes/blob/master/cert-manager/certificates.yaml) files.  
Step 2 - Run command - kubectl apply -f cluster-issuer.yaml  
Step 3 - Run command - kubectl apply -f certificates.yaml