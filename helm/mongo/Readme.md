## Deploy MongoDB ReplicaSet and Backup
[MongoDB ReplicaSet](https://github.com/cvallance/mongo-k8s-sidecar) deploys a 2 node MongoDB ReplicaSet with persistent SSD storage which is backed by Azure Managed Disks.

[MongoDB Backup](https://github.com/stefanprodan/mgob) deploys a Kubernetes Pod which takes MongoDB Backups and uploads to an Azure Storage Account.

Step 1 - Ensure the relevant storageclasses are installed which can be found in the [storageclasses](https://github.com/cloudpea/Kubernetes/blob/master/storageclasses/) section of this repository:  
kubectl apply -f storageclasses.yaml  

Step 2 - Provision the MongoDB Replica Set via Helm using the command:  
helm install . --name mongo \  
--namespace <namespace> \  
--set databaseName=<dbName> \  
--set storageContainer=<storageContainerName> \  
--set storageConnection=<storageConnectionString>