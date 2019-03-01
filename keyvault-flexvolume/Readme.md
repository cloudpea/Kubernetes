## Deploy Azure KeyVault Flex Volume
[KeyVault-FlexVol](https://github.com/Azure/kubernetes-keyvault-flexvol) allows developers to mount multiple secrets, keys, and certs stored in Key Management Systems into their pods as a volume. Once the Volume is attached, the data in it is mounted into the container's file system.

Step 1 - Create an Azure AD Service Principal and grant Get permissions for Secrets, Keys and Certs in the Azure KeyVault.  
Step 2 - Update [keyvault-flex.deploy.yaml](https://github.com/cloudpea/Kubernetes/blob/master/keyvault-flexvolume/keyvault-flex.deploy.yaml) with the clientid & clientsecret values.
Step 3 - Run command - kubectl apply -f keyvault-flex.deploy.yaml
