# Cheat Sheet

<br><br>

## Create an alias for kubectl:
alias k=kubectl

## Change context:
k config use-context [cluster-name]

## View config, such as contexts:
k config view

## View k8s version:
k version

## Display cluster info:
k cluster-info

<br><br>

## Apply a k8s manifest:
k apply -f [file-name]

## Delete a k8s manifest:
k delete -f [file-name]

<br><br>

## List pods in the default namespace:
k get po

## List pods in a specific namespace:
k get po -n [namespace]

## List pods in all namespaces:
k get po -A
k get po --all-namespaces

## List pods in all namespaces, display only name:
k get po -A -o name

## List pods in all namespaces, display IP and node information:
k get po -A -o wide

## List pods in all namespaces, sorted by age (descending order):
k get po --sort-by=.metadata.creationTimestamp -A

## List pods in all namespaces, sorted by age (ascending order):
k get po --sort-by=.metadata.creationTimestamp -A | tac

## List all pods with a specific label in all namespaces:
k get po -l [label] -A
k get po --selector [label] -A

## List a specific pod:
k get po [pod-ID] -n [namespace]

## List a specific pod, verbose output in YAML:
k get po [pod-ID] -n [namespace] -o yaml

## Describe a specific pod:
k describe po [pod-ID] -n [namespace]

## Get logs from a specific pod:
k logs [pod-ID] -n [namespace]

## Run command in a specific pod:
k exec [pod-ID] -n [namespace] -- [command]

## Check translate public IP for a specific pod:
k exec [pod-ID] -n [namespace] -- curl -s ifconfig.co

<br><br>

## Scale a deployment interactively:
k scale --replicas [replica-count] deploy/[deployment-name] -n [namespace]

## Scale a ReplicaSet interactively:
k scale --replicas [replica-count] rs/[deployment-name] -n [namespace]

<br><br>

## List namespaces:
k get ns

## List nodes:
k get no

## Describe a specific node:
k describe no [node-name]

## List deployments in all namespaces:
k get deploy -A

## List deployments in all namespaces, display containers, images and selector:
k get deploy -A -o wide

## List all deployment with a specific label in all namespaces:
k get deploy -l [label] -A

## Describe a specific deployment:
k describe deploy [deployment-name] -n [namespace]

## Get ReplicaSets in all namespaces:
k get rs -A

## Get DaemonSets in all namespaces:
k get ds -A

## Get Ingresses in all namespaces:
k get ing -A

## Get Services in all namespaces:
k get svc -A

## Get Endpoints in all namespaces:
k get ep -A

## Get NetworkPolicies in all namespaces:
k get netpol -A

## Get all events from all namespaces:
k get ev -A

## Get all events from a specific namespaces (with watch flag in order to "live tail"):
k get ev -n [namespace] -w

## Get all resources from all namespaces (not actually all, but the most useful: pod, service, daemonset, deployment, replicaset, horizontalpodautoscaler):
k get all -A

## Get all CustomResourceDefinitions from all namespaces
k get crd -A

## Get a list of all supported resource types and their shortnames:
k api-resources

## Get a list of all supported resource types, their shortnames and supported verbs:
k api-resources -o wide

<br><br>

## Get metrics for all nodes:
k top no

## Get metrics for all pods in all namespaces:
k top po -A

## Get metrics for all pods with a specific label in all namespaces:
k top po -l [label] -A

<br><br>

## Verify status of a specific deployment rollout:
k rollout status deploy/[deployment-name] -n [namespace]

## Check rollout history for a specific deployment:
k rollout history deploy/[deployment-name] -n [namespace]

## Undo a rolled out deployment:
k rollout undo deploy/[deployment-name] -n [namespace]

<br><br>

## Delete a specific pod:
k delete [pod-ID] -n [namespace]

## Delete all pods with a specific label in all namespaces:
k delete -l [label] -A

## Drain node and mark as unschedulable:
k drain [node-name]

## Mark node as unschedulable:
k cordon [node-name]

## Unmark node as unschedulable:
k uncordon [node-name]

<br><br>

# Taint a specific node:
k taint no [node-name] key=[taint]

## List taints on all nodes:
k describe no | grep Taints

## List tolerations for pods in all namespaces:
k get po -A -o yaml | grep tolerations: