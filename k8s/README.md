# Cheat Sheet - Kubernetes

<br>

## Official docs:
https://kubernetes.io/docs/reference/kubectl/

<br><br>

## Check Kubernetes version:
```shell
kubectl version
```

<br><br>

## Contextual help:
```shell
kubectl --help
kubectl -h
```

<br><br>

## Change context globally:
```shell
kubectl config use-context <cluster-name>
```

## Change context only for a single command:
```shell
kubectl <subcommand> --context <cluster-name>
```

## View config, such as contexts:
```shell
kubectl config view
```

## Display cluster info:
```shell
kubectl cluster-info
```

<br><br>

## Apply a Kubernetes manifest:
```shell
kubectl apply --filename <filename>
kubectl apply -f <filename>
```

## Delete a Kubernetes manifest:
```shell
kubectl delete --filename <filename>
kubectl delete -f <filename>
```

<br><br>

## List pods in the default namespace:
```shell
kubectl get po
```

## List pods in a specific namespace:
```shell
kubectl get po --namespace <namespace>
kubectl get po -n <namespace>
```

## List pods in all namespaces:
```shell
kubectl get po --all-namespaces
kubectl get po -A
```

## Count number of pods in all namespaces:
```shell
kubectl get po --all-namespaces | wc -l
kubectl get po -A | wc -l
```

## List pods in all namespaces, display only name:
```shell
kubectl get po --all-namespaces -o name
kubectl get po -A -o name
```

## List pods in all namespaces, display IP and node information:
```shell
kubectl get po --all-namespaces --output wide
kubectl get po -A -o wide
```

## List pods in all namespaces, sorted by age (descending order):
```shell
kubectl get po --sort-by=.metadata.creationTimestamp -A
```

## List pods in all namespaces, sorted by age (ascending order):
```shell
kubectl get po --sort-by=.metadata.creationTimestamp --all-namespaces | tail -r
kubectl get po --sort-by=.metadata.creationTimestamp -A | tail -r
kubectl get po --sort-by=.metadata.creationTimestamp --all-namespaces | tac
kubectl get po --sort-by=.metadata.creationTimestamp -A | tac
```

## List all pods with a specific label in all namespaces:
```shell
kubectl get po --selector <label> --all-namespaces
kubectl get po -l <label> -A
```

## List a specific pod:
```shell
kubectl get po <pod-ID> --namespace <namespace>
kubectl get po <pod-ID> -n <namespace>
```

## List a specific pod, verbose output in YAML:
```shell
kubectl get po <pod-ID> --namespace <namespace> --output yaml
kubectl get po <pod-ID> -n <namespace> -o yaml
```

## List pods in all namespaces that are not Running:
```shell
kubectl get po --all-namespaces | grep --invert-match Running
kubectl get po -A | grep -v Running
```

## Count number of pods that are not Running:
```shell
kubectl get po --all-namespaces | grep --invert-match Running | wc -l
kubectl get po -A | grep -v Running | wc -l
```

## List pods in all namespaces that are stuck in ContainerCreating:
```shell
kubectl get po --all-namespaces | grep ContainerCreating
kubectl get po -A | grep ContainerCreating
```

## Count number of pods that are stuck in ContainerCreating:
```shell
kubectl get po --all-namespaces | grep ContainerCreating | wc -l
kubectl get po -A | grep ContainerCreating | wc -l
```

## Describe a specific pod:
```shell
kubectl describe po <pod-ID> --namespace <namespace>
kubectl describe po <pod-ID> -n <namespace>
```

## Get logs from a specific pod:
```shell
kubectl logs <pod-ID> --namespace <namespace>
kubectl logs <pod-ID> -n <namespace>
```

<br><br>

## Run command in a specific pod:
```shell
kubectl exec <pod-ID> --namespace <namespace> -- <command>
kubectl exec <pod-ID> -n <namespace> -- <command>
```

## Start an interactive shell in a specific pod:
```shell
kubectl exec --interactive --tty <pod-ID> --namespace <namespace> -- /bin/bash
kubectl exec -it <pod-ID> -n <namespace> -- /bin/bash
```

## Check public IP used for a specific pod:
```shell
kubectl exec <pod-ID> --namespace <namespace> -- curl --silent ifconfig.co
kubectl exec <pod-ID> -n <namespace> -- curl -s ifconfig.co
```

<br><br>

## Scale a deployment interactively:
```shell
kubectl scale --replicas <replica-count> deploy/<deployment-name> --namespace <namespace>
kubectl scale --replicas <replica-count> deploy/<deployment-name> -n <namespace>
```

## Scale a ReplicaSet interactively:
```shell
kubectl scale --replicas <replica-count> rs/<deployment-name> --namespace <namespace>
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
kubectl get deploy --all-namespaces
kubectl get deploy -A
```

## List deployments in all namespaces, display containers, images and selector:
```shell
kubectl get deploy --all-namespaces --output wide
kubectl get deploy -A -o wide
```

## List all deployment with a specific label in all namespaces:
```shell
kubectl get deploy --selector <label> --all-namespaces
kubectl get deploy -l <label> -A
```

## Describe a specific deployment:
```shell
kubectl describe deploy <deployment-name> --namespace <namespace>
kubectl describe deploy <deployment-name> -n <namespace>
```

## Get ReplicaSets in all namespaces:
```shell
kubectl get rs --all-namespaces
kubectl get rs -A
```

## Get DaemonSets in all namespaces:
```shell
kubectl get ds --all-namespaces
kubectl get ds -A
```

## Get Ingresses in all namespaces:
```shell
kubectl get ing --all-namespaces
kubectl get ing -A
```

## Get Services in all namespaces:
```shell
kubectl get svc --all-namespaces
kubectl get svc -A
```

## Get Endpoints in all namespaces:
```shell
kubectl get ep --all-namespaces
kubectl get ep -A
```

## Get NetworkPolicies in all namespaces:
```shell
kubectl get netpol --all-namespaces
kubectl get netpol -A
```

## Get all events from all namespaces:
```shell
kubectl get ev --all-namespaces
kubectl get ev -A
```

## Get all events from a specific namespaces (with watch flag in order to "live tail"):
```shell
kubectl get ev --namespace <namespace> --watch
kubectl get ev -n <namespace> -w
```

## Get all resources from all namespaces (not actually all, but the most useful: pod, service, daemonset, deployment, replicaset, horizontalpodautoscaler):
```shell
kubectl get all --all-namespaces
kubectl get all --all-namespaces
```

## Get all CustomResourceDefinitions from all namespaces
```shell
kubectl get crd --all-namespaces
kubectl get crd --all-namespaces
```

## Get a list of all supported resource types and their shortnames:
```shell
kubectl api-resources
```

## Get a list of all supported resource types, their shortnames and supported verbs:
```shell
kubectl api-resources --output wide
kubectl api-resources -o wide
```

<br><br>

## Get metrics for all nodes:
```shell
kubectl top no
```

## Get metrics for all pods in all namespaces:
```shell
kubectl top po --all-namespaces
kubectl top po -A
```

## Get metrics for all pods with a specific label in all namespaces:
```shell
kubectl top po --selector <label> --all-namespaces
kubectl top po -l <label> -A
```

<br><br>

## Verify status of a specific deployment rollout:
```shell
kubectl rollout status deploy/<deployment-name> --namespace <namespace>
kubectl rollout status deploy/<deployment-name> -n <namespace>
```

## Check rollout history for a specific deployment:
```shell
kubectl rollout history deploy/<deployment-name> --namespace <namespace>
kubectl rollout history deploy/<deployment-name> -n <namespace>
```

## Undo a rolled out deployment:
```shell
kubectl rollout undo deploy/<deployment-name> --namespace <namespace>
kubectl rollout undo deploy/<deployment-name> -n <namespace>
```

<br><br>

## Delete a specific pod:
```shell
kubectl delete <pod-ID> --namespace <namespace>
kubectl delete <pod-ID> -n <namespace>
```

## Delete all pods with a specific label in all namespaces:
```shell
kubectl delete --selector <label> --all-namespaces
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
kubectl get po --all-namespace --output yaml | grep tolerations:
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