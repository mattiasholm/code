# Cheat Sheet

<br>

## Official docs:
https://kubernetes.io/docs/reference/kubectl/

<br><br>

## Create an alias for kubectl:
alias k='kubectl'

## Change context:
kubectl config use-context [cluster-name]

## View config, such as contexts:
kubectl config view

## View k8s version:
kubectl version

## Display cluster info:
kubectl cluster-info

<br><br>

## Apply a k8s manifest:
kubectl apply -f [file-name]

## Delete a k8s manifest:
kubectl delete -f [file-name]

<br><br>

## List pods in the default namespace:
kubectl get po

## List pods in a specific namespace:
kubectl get po -n [namespace]

## List pods in all namespaces:
kubectl get po -A
kubectl get po --all-namespaces

## Count number of pods in all namespaces:
kubectl get po -A | wc -l

## List pods in all namespaces, display only name:
kubectl get po -A -o name

## List pods in all namespaces, display IP and node information:
kubectl get po -A -o wide

## List pods in all namespaces, sorted by age (descending order):
kubectl get po --sort-by=.metadata.creationTimestamp -A

## List pods in all namespaces, sorted by age (ascending order):
kubectl get po --sort-by=.metadata.creationTimestamp -A | tac

## List all pods with a specific label in all namespaces:
kubectl get po -l [label] -A
kubectl get po --selector [label] -A

## List a specific pod:
kubectl get po [pod-ID] -n [namespace]

## List a specific pod, verbose output in YAML:
kubectl get po [pod-ID] -n [namespace] -o yaml

## List pods in all namespaces that are not Running:
kubectl get po -A | grep -v Running

## Count number of pods that are not Running:
kubectl get po -A | grep -v Running | wc -l

## List pods in all namespaces that are stuck in ContainerCreating:
kubectl get po -A | grep ContainerCreating

## Count number of pods that are stuck in ContainerCreating:
kubectl get po -A | grep ContainerCreating | wc -l

## Describe a specific pod:
kubectl describe po [pod-ID] -n [namespace]

## Get logs from a specific pod:
kubectl logs [pod-ID] -n [namespace]

<br><br>

## Run command in a specific pod:
kubectl exec [pod-ID] -n [namespace] -- [command]

## Start an interactive shell in a specific pod:
kubectl exec -it [pod-ID] -n [namespace] -- /bin/bash

## Check public IP used for a specific pod:
kubectl exec [pod-ID] -n [namespace] -- curl -s ifconfig.co

<br><br>

## Scale a deployment interactively:
kubectl scale --replicas [replica-count] deploy/[deployment-name] -n [namespace]

## Scale a ReplicaSet interactively:
kubectl scale --replicas [replica-count] rs/[deployment-name] -n [namespace]

<br><br>

## List namespaces:
kubectl get ns

## List nodes:
kubectl get no

## Describe a specific node:
kubectl describe no [node-name]

## List deployments in all namespaces:
kubectl get deploy -A

## List deployments in all namespaces, display containers, images and selector:
kubectl get deploy -A -o wide

## List all deployment with a specific label in all namespaces:
kubectl get deploy -l [label] -A

## Describe a specific deployment:
kubectl describe deploy [deployment-name] -n [namespace]

## Get ReplicaSets in all namespaces:
kubectl get rs -A

## Get DaemonSets in all namespaces:
kubectl get ds -A

## Get Ingresses in all namespaces:
kubectl get ing -A

## Get Services in all namespaces:
kubectl get svc -A

## Get Endpoints in all namespaces:
kubectl get ep -A

## Get NetworkPolicies in all namespaces:
kubectl get netpol -A

## Get all events from all namespaces:
kubectl get ev -A

## Get all events from a specific namespaces (with watch flag in order to "live tail"):
kubectl get ev -n [namespace] -w

## Get all resources from all namespaces (not actually all, but the most useful: pod, service, daemonset, deployment, replicaset, horizontalpodautoscaler):
kubectl get all -A

## Get all CustomResourceDefinitions from all namespaces
kubectl get crd -A

## Get a list of all supported resource types and their shortnames:
kubectl api-resources

## Get a list of all supported resource types, their shortnames and supported verbs:
kubectl api-resources -o wide

<br><br>

## Get metrics for all nodes:
kubectl top no

## Get metrics for all pods in all namespaces:
kubectl top po -A

## Get metrics for all pods with a specific label in all namespaces:
kubectl top po -l [label] -A

<br><br>

## Verify status of a specific deployment rollout:
kubectl rollout status deploy/[deployment-name] -n [namespace]

## Check rollout history for a specific deployment:
kubectl rollout history deploy/[deployment-name] -n [namespace]

## Undo a rolled out deployment:
kubectl rollout undo deploy/[deployment-name] -n [namespace]

<br><br>

## Delete a specific pod:
kubectl delete [pod-ID] -n [namespace]

## Delete all pods with a specific label in all namespaces:
kubectl delete -l [label] -A

## Drain node and mark as unschedulable:
kubectl drain [node-name]

## Mark node as unschedulable:
kubectl cordon [node-name]

## Unmark node as unschedulable:
kubectl uncordon [node-name]

<br><br>

# Taint a specific node:
kubectl taint no [node-name] key=[taint]

## List taints on all nodes:
kubectl describe no | grep Taints

## List tolerations for pods in all namespaces:
kubectl get po -A -o yaml | grep tolerations:

<br><br>

## List nodes and show labels:
kubectl get nodes --show-labels

## List namespaces and show labels:
kubectl get ns --show-labels

## Label a specific node:
kubectl label no [node-name] [label]

## Label a specific namespace
kubectl label ns [node-name] [label]