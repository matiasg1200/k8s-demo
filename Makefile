SHELL := /bin/bash
UNAME := $(shell uname)
EXEC_VERSION := 0.0.10

ifeq ($(UNAME), Linux)
  open_browser_tab = xdg-open
  date_cmd = date
  xargs_cmd = xargs
  sed_cmd = sed
else ifeq ($(UNAME), Darwin)
  open_browser_tab = open
  date_cmd = gdate
  xargs_cmd = gxargs
  sed_cmd = gsed
endif

## make deploy-all # Deploy whole stack
.PHONY: deploy-all
deploy-all: kubectl apply -f
deploy-all: kubectl apply -f workload/
deploy-all: kubectl apply -f services/

## make deploy res=ENV # Deploy single resource (workload + service)