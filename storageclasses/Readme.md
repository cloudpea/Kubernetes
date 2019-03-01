## Create Storage Classes
[Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/) allow Kubernetes to utilise existing storage providers to host data inside storage volumes backed by the storage provider. This gives developers the ability to store data on volumes with different quality of service levels such as HDD or SSD backed storage disks.

Step 1 - Provision Azure Storage Classes with the below command:  
kubectl apply -f storageclasses.yaml