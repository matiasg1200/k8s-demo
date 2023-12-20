# k8s-demo

This demo deploys a small monitoring suite in a Kubernetes cluster using Prometheus as TSDB, Grafana for data visualization and Telegraf to create sample metrics

# List of resoruces

| Type                  | Name                         |
| --------------------- | ---------------------------- |
| ClusterRole           | prometheus-pod-role          |
| ServiceAccount        | prometheus-sa                |
| ClusterRoleBidning    | prometheus-pods-role-binding |
| Service-ClusterIp     | telegraf-service             |
| Service-NodePort      | prometheus-service           |
| Service-NodePort      | grafana-service              |
| configMap             | telegraf-service             |
| configMap             | prometheus-service           |
| configMap             | grafana-service              |
| PersistentVolumeClaim | grafana-pvc                  |

