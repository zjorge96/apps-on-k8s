# Grafana and InfluxDB

This is a simple example of how to use Grafana with InfluxDB. It uses the yaml files from the [Grafana Kubernetes example](https://grafana.com/docs/grafana/latest/setup-grafana/installation/kubernetes/) and the [InfluxDB Helm charts](https://github.com/influxdata/helm-charts/tree/master/charts/influxdb2) to deploy a Grafana instance and an InfluxDB instance.

## Prerequisites

* Connected to a Kubernetes cluster. For Azure, look at the [Azure platform](https://github.com/zjorge96/apps-on-k8s/tree/main/platform/azure) for instructions on how to create and connect to a cluster.
* [Helm](https://helm.sh/) installed

## Setup

1. Clone this repo
2. Run "grafana_build.bash" to deploy the Grafana and InfluxDB instances
- To delete the Grafana and InfluxDB instances, run "grafana_build.bash -u"

### Grafana

To view the Grafana instance locally, run the following command:

```bash
kubectl port-forward service/grafana 3000:3000
```

Then, navigate to http://localhost:3000 to view the Grafana instance.

### InfluxDB

To view the InfluxDB instance locally, run the following command:

```bash
# The release name is of your choosing and can be changed within the grafana_build.bash script. The default is "grafana".
kubectl port-forward service/$RELEASE_NAME-influxdb2 8086:80
```

Then, navigate to http://localhost:8086 to view the InfluxDB instance.

### To connect Grafana to InfluxDB

1. After port-forwarding and logging into both, go to InfluxDB and select the 'admin - influxdata' box in the top left.
2. Click on 'Create Organization' in the sidebar that appears.
3. This will allow you to make a new organization and a new bucket. We will name them as follows:
- Organization: 'liatrio'
- Bucket: 'grafana'
4. Go to Grafana and click on the gear icon in the left sidebar.
5. Click on 'Add Data Source'.
6. Select 'InfluxDB'.
7. Select the following:
- Query Language: Flux
- HTTP URL: http://$RELEASE_NAME-influxdb2:80
- Under 'Auth', select 'Basic Auth'.
- Username: admin
- Password: (the password you got from the InfluxDB installation)
- Under the 'InfluxDB Details' section, select 'liatrio' as the organization and 'grafana' as the bucket.
- Token: This token can be found in the InfluxDB UI under 'Load Data' -> 'API Tokens' -> 'admin's Token'.
8. Click 'Save & Test'.