#!/bin/bash
read -p "Input your service account username: " username
kubectl create serviceaccount $dashboardUsername -n kube-system
kubectl create clusterrolebinding $dashboardUsername -n kube-system --clusterrole=view --serviceaccount=kube-system:$username
kubectl get secret -n kube-system $(kubectl get serviceaccount $dashboardUsername -n kube-system -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
echo " "
echo "Please save the username and above authentication key in Secret Server."