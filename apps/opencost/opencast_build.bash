helm install my-prometheus --repo https://prometheus-community.github.io/helm-charts prometheus \
  --namespace prometheus --create-namespace \
  --set pushgateway.enabled=false \
  --set alertmanager.enabled=false \
  -f https://raw.githubusercontent.com/opencost/opencost/develop/kubernetes/prometheus/extraScrapeConfigs.yaml

kubectl apply --namespace opencost -f https://raw.githubusercontent.com/opencost/opencost/develop/kubernetes/opencost.yaml