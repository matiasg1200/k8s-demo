SHELL := /bin/bash
UNAME := $(shell uname)
EXEC_VERSION := 0.0.10
    
## make deploy-all # Deploy whole stack
.PHONY: deploy-all
deploy-all:
	@kubectl create -f demo-namespace.yaml
	@kubectl apply -n demo -f workloads/telegraf-deployment.yaml
	@kubectl apply -n demo -f services/telegraf-clusterip.yaml
	@kubectl apply -n demo -f prometheus-rbac.yaml
	@kubectl apply -n demo -f workloads/prometheus.yaml
	@kubectl apply -n demo -f services/prometheus-nodeport.yaml
	@kubectl apply -n demo -f workloads/grafana-deployment.yaml
	@kubectl apply -n demo -f services/grafana-nodeport.yaml

## make clean-up
.PHONY: clean-up
clean-up:
	@kubectl delete clusterrole prometheus-pods-role 
	@kubectl delete clusterrolebinding prometheus-pods-role-binding
	@kubectl delete namespace demo

