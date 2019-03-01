## Deploy MongoDB ReplicaSet and Backup
[MongoDB ReplicaSet](https://github.com/cvallance/mongo-k8s-sidecar) deploys a 3 node MongoDB ReplicaSet with persistent SSD storage which is backed by Azure Managed Disks.

Step 1 - Run command - kubectl apply -f mongodb.all.yaml

[MongoDB Backup](https://github.com/stefanprodan/mgob) deploys a Kubernetes Pod which takes MongoDB Backups and uploads to an Azure Storage Account.

Step 1 - Update the [mgob.cfg.yaml](https://github.com/cloudpea/Kubernetes/blob/master/deployments/mongo/mgob.cfg.yaml) & [mgob.deploy.yaml](https://github.com/cloudpea/Kubernetes/blob/master/deployments/mongo/mgob.deploy.yaml) files with the correct Storage Account and Database information.  
Step 2 - Run the command - kubectl apply -f mgob.cfg.yaml  
Step 3 - Run the command - kubectl apply -f mgob.deploy.yaml