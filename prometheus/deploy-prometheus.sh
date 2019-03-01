#!/bin/bash
cd "$(dirname "$(realpath "$0")")";
helm install coreos/prometheus-operator --name prometheus-operator --namespace prometheus
helm install coreos/kube-prometheus --name kube-prometheus --namespace prometheus --set networkPolicy.enabled=true
kubectl apply -f prometheus-networkpolicy.yaml
kubectl patch deployment -n kube-system kube-dns-v20 --patch "$(cat kube-dns-metrics-patch.yaml)"
kubectl -n monitoring get servicemonitor kube-prometheus-exporter-kubelets -o yaml | sed 's/https/http/' | kubectl replace -f -
kubectl apply -f grafana-ingress.yaml