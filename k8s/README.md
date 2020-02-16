# Cheat Sheet - Kubernetes

<br>

## Official docs:
https://kubernetes.io/docs/reference/kubectl/

<br><br>

## Change context:
```shell
kubectl config use-context <cluster-name>
```

## View config, such as contexts:
```shell
kubectl config view
```

## View k8s version:
```shell
kubectl version
```

## Display cluster info:
```shell
kubectl cluster-info
```

<br><br>

## Apply a k8s manifest:
```shell
kubectl apply -f <file-name>
```

## Delete a k8s manifest:
```shell
kubectl delete -f <file-name>
```

<br><br>

## List pods in the default namespace:
```shell
kubectl get po
```

## List pods in a specific namespace:
```shell
kubectl get po -n <namespace>
```

## List pods in all namespaces:
```shell
kubectl get po -A
kubectl get po --all-namespaces
```

## Count number of pods in all namespaces:
```shell
kubectl get po -A | wc -l
```

## List pods in all namespaces, display only name:
```shell
kubectl get po -A -o name
```

## List pods in all namespaces, display IP and node information:
```shell
kubectl get po -A -o wide
```

## List pods in all namespaces, sorted by age (descending order):
```shell
kubectl get po --sort-by=.metadata.creationTimestamp -A
```

## List pods in all namespaces, sorted by age (ascending order):
```shell
kubectl get po --sort-by=.metadata.creationTimestamp -A | tac
```

## List all pods with a specific label in all namespaces:
```shell
kubectl get po -l <label> -A
kubectl get po --selector <label> -A
```

## List a specific pod:
```shell
kubectl get po <pod-ID> -n <namespace>
```

## List a specific pod, verbose output in YAML:
```shell
kubectl get po <pod-ID> -n <namespace> -o yaml
```

## List pods in all namespaces that are not Running:
```shell
kubectl get po -A | grep -v Running
```

## Count number of pods that are not Running:
```shell
kubectl get po -A | grep -v Running | wc -l
```

## List pods in all namespaces that are stuck in ContainerCreating:
```shell
kubectl get po -A | grep ContainerCreating
```

## Count number of pods that are stuck in ContainerCreating:
```shell
kubectl get po -A | grep ContainerCreating | wc -l
```

## Describe a specific pod:
```shell
kubectl describe po <pod-ID> -n <namespace>
```

## Get logs from a specific pod:
```shell
kubectl logs <pod-ID> -n <namespace>
```

<br><br>

## Run command in a specific pod:
```shell
kubectl exec <pod-ID> -n <namespace> -- <command>
```

## Start an interactive shell in a specific pod:
```shell
kubectl exec -it <pod-ID> -n <namespace> -- /bin/bash
```

## Check public IP used for a specific pod:
```shell
kubectl exec <pod-ID> -n <namespace> -- curl -s ifconfig.co
```

<br><br>

## Scale a deployment interactively:
```shell
kubectl scale --replicas <replica-count> deploy/<deployment-name> -n <namespace>
```

## Scale a ReplicaSet interactively:
```shell
kubectl scale --replicas <replica-count> rs/<deployment-name> -n <namespace>
```

<br><br>

## List namespaces:
```shell
kubectl get ns
```

## List nodes:
```shell
kubectl get no
```

## Describe a specific node:
```shell
kubectl describe no <node-name>
```

## List deployments in all namespaces:
```shell
kubectl get deploy -A
```

## List deployments in all namespaces, display containers, images and selector:
```shell
kubectl get deploy -A -o wide
```

## List all deployment with a specific label in all namespaces:
```shell
kubectl get deploy -l <label> -A
```

## Describe a specific deployment:
```shell
kubectl describe deploy <deployment-name> -n <namespace>
```

## Get ReplicaSets in all namespaces:
```shell
kubectl get rs -A
```

## Get DaemonSets in all namespaces:
```shell
kubectl get ds -A
```

## Get Ingresses in all namespaces:
```shell
kubectl get ing -A
```

## Get Services in all namespaces:
```shell
kubectl get svc -A
```

## Get Endpoints in all namespaces:
```shell
kubectl get ep -A
```

## Get NetworkPolicies in all namespaces:
```shell
kubectl get netpol -A
```

## Get all events from all namespaces:
```shell
kubectl get ev -A
```

## Get all events from a specific namespaces (with watch flag in order to "live tail"):
```shell
kubectl get ev -n <namespace> -w
```

## Get all resources from all namespaces (not actually all, but the most useful: pod, service, daemonset, deployment, replicaset, horizontalpodautoscaler):
```shell
kubectl get all -A
```

## Get all CustomResourceDefinitions from all namespaces
```shell
kubectl get crd -A
```

## Get a list of all supported resource types and their shortnames:
```shell
kubectl api-resources
```

## Get a list of all supported resource types, their shortnames and supported verbs:
```shell
kubectl api-resources -o wide
```

<br><br>

## Get metrics for all nodes:
```shell
kubectl top no
```

## Get metrics for all pods in all namespaces:
```shell
kubectl top po -A
```

## Get metrics for all pods with a specific label in all namespaces:
```shell
kubectl top po -l <label> -A
```

<br><br>

## Verify status of a specific deployment rollout:
```shell
kubectl rollout status deploy/<deployment-name> -n <namespace>
```

## Check rollout history for a specific deployment:
```shell
kubectl rollout history deploy/<deployment-name> -n <namespace>
```

## Undo a rolled out deployment:
```shell
kubectl rollout undo deploy/<deployment-name> -n <namespace>
```

<br><br>

## Delete a specific pod:
```shell
kubectl delete <pod-ID> -n <namespace>
```

## Delete all pods with a specific label in all namespaces:
```shell
kubectl delete -l <label> -A
```

## Drain node and mark as unschedulable:
```shell
kubectl drain <node-name>
```

## Mark node as unschedulable:
```shell
kubectl cordon <node-name>
```

## Unmark node as unschedulable:
```shell
kubectl uncordon <node-name>
```

<br><br>

# Taint a specific node:
```shell
kubectl taint no <node-name> key=<taint>
```

## List taints on all nodes:
```shell
kubectl describe no | grep Taints
```

## List tolerations for pods in all namespaces:
```shell
kubectl get po -A -o yaml | grep tolerations:
```

<br><br>

## List nodes and show labels:
```shell
kubectl get nodes --show-labels
```

## List namespaces and show labels:
```shell
kubectl get ns --show-labels
```

## Label a specific node:
```shell
kubectl label no <node-name> <label>
```

## Label a specific namespace
```shell
kubectl label ns <node-name> <label>
```


<!-- TO-DO: Förtydliga genom exempel med fulla växlar för varje kommando, t.ex. --all-namespaces istället för -A-->