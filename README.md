# k8s-demo

This demo deploys a small monitoring suite in a Kubernetes cluster using Prometheus as TSDB, Grafana for data visualization and Telegraf to create sample metrics.


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


# Requiermnets

You will need a running Kubernetes cluster (could be minikube, kubeadm, GKE, EKS, etc.. ) and `kubectl` cli.

## Deploy stack

`make deploy-all`

This will create a `demo` namespace and deploy all resoruces in that namespace. If you would rather deploy the stack gradually you can follow the order of the `kubectl apply` commands from the `Makefile`.

> If you already have a `demo` workspace in your cluster the make command will fail with: `Error from server (AlreadyExists): namespaces "demo" already exists`
If that's the case just change `demo` to use a different namespace. Make sure to change the namespace in all `kubectl apply` commands from the [Makefile](https://github.com/matiasg1200/k8s-demo/blob/main/Makefile) and also on the [prometheus-rbac.yaml](https://github.com/matiasg1200/k8s-demo/blob/main/prometheus-rbac.yaml) file (**L15** and and **L29**).

## Interacting with the stack

The Prometheus and Grafana `NodePorts` will open up ports `30001` and `30002` respectivly on the node were the pods are running so you should be able to logging into the UIs by just visting http://<node_ip_address>/30001 for Prometheus and http://<node_ip_address>/30002 for Grafana, from your browser. If you are running minikube you should be able to get the ip address assgined to the node by running one of the following commands: 

- For prometheus:
`minikube -n demo service prometheus-service --url`

- For grafana:
`minikube -n demo service grafana-service --url`

> If you used a namespace different than *demo* make sure to change it here as well.

The initial username and password for grafana is as defualt, `admin` for both. It will ask you to change the password after the initial login. 

Finally, if you want to interact with the stack using `kubectl` just remember to use the `-n` flag to specifiy the namespace were the resource are running. For example:

`kubectl get all -n demo`

You could optinally create a new context using the `kubectl config set-context` command or by updating the `kubeconfig` file

> Be cautios as changes to the kubeconfig file via command line using `kubectl config` or via manual update could break your current kubectl configuration. For further reference visist: https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/

## Cleaning up

`make clean-up`

This will delete the namespace were the resource are running and will also delete the `ClusterRole` and `ClusterRoleBinding` created for Promehteus. 