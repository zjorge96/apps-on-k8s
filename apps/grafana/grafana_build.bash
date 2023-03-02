RELEASE_NAME=grafana

# Make an "if" that checks if the "-u" flag is present. if so then uninstall the release. Else, install the release.
if [[ $1 == "-u" ]]; then
    helm uninstall $RELEASE_NAME > /dev/null
    kubectl delete pvc -l app.kubernetes.io/instance=$RELEASE_NAME > /dev/null
    echo "Uninstalled InfluxDB"
    kubectl delete -f grafana.yaml > /dev/null
    echo "Uninstalled Grafana"
    exit 0
else
    echo "Creating the InfluxDB deployment"
    helm repo add influxdata https://helm.influxdata.com/ > /dev/null
    helm upgrade --install $RELEASE_NAME influxdata/influxdb2 > /dev/null
    POD="$RELEASE_NAME-influxdb2-0"
    kubectl wait --for=condition=Ready pod/$POD --timeout=60s > /dev/null
    echo "Finished installing InfluxDB"
    echo
    echo "InfluxDB:"
    echo "To view: kubectl port-forward service/$RELEASE_NAME-influxdb2 8086:80"
    echo "Username: admin"
    echo "Password: $(echo $(kubectl get secret $RELEASE_NAME-influxdb2-auth -o "jsonpath={.data['admin-password']}" --namespace default | base64 --decode))"
    echo

    echo "Creating the Grafana deployment"
    kubectl apply -f grafana.yaml > /dev/null
    POD=$(kubectl get pod -l app=grafana -o jsonpath="{.items[0].metadata.name}")
    kubectl wait --for=condition=Ready pod/$POD --timeout=60s > /dev/null
    echo "Finished installing Grafana"
    echo
    echo "Grafana:"
    echo "To view: kubectl port-forward service/grafana 3000:3000"
    echo "Username: admin"
    echo "Password: admin (update to 'testinggrafana' after login)"
    echo
    echo "For details connecting Grafana to InfluxDB, check the README.md"
fi