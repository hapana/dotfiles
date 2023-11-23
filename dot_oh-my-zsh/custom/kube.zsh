export PATH=$PATH:$HOME/.linkerd2/bin

# Main alias
alias k="kubectl"

# Helper functions to ge the first of things
get_pod_name() {
  echo $(kubectl get pods -n $(get_namespace $1)| grep $2 | cut -d' ' -f1 | head -n 1)
}

get_deployment_name(){
  echo $(kubectl get deployments -n $(get_namespace $1) | grep $2 | cut -d' ' -f1)
}

get_namespace(){
  echo $(kubectl get namespaces | grep $1 | cut -d' ' -f1 | head -n 1)
}

# Load autocompletions
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# k_install 1.21.0
kinstall() {
  pushd /tmp
  if [[ -n $1 ]];then
    curl -LO "https://dl.k8s.io/release/v$1/bin/darwin/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/v$1/bin/darwin/amd64/kubectl.sha256"
    echo "$(<kubectl.sha256)  kubectl" | shasum -a 256 --check
  else
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl.sha256"
    echo "$(<kubectl.sha256)  kubectl" | shasum -a 256 --check
  fi
  chmod +x /tmp/kubectl
  popd
  mv /tmp/kubectl /usr/local/bin/kubectl
}

# kbash <namespace> <pod> <container>
kbash () {
  if [[ -n $3 ]];then
    kubectl exec -it $(get_pod_name $1 $2) -n $(get_namespace $1) --container $3 /bin/bash
  else
    kubectl exec -it $(get_pod_name $1 $2) -n $(get_namespace $1) /bin/bash
  fi
}

# kleft <namespace>
kleft () {
  kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $(get_namespace $1)
}

# kbsh <namespace> <pod> <container>
kbsh () {
  if [[ -n $3 ]];then
    kubectl exec -it $(get_pod_name $1 $2) -n $(get_namespace $1) --container $3 /bin/sh
  else
    kubectl exec -it $(get_pod_name $1 $2) -n $(get_namespace $1) /bin/sh
  fi
}

# kpf <namespace> <pod> <port>
kpf () {
    kubectl port-forward $(get_pod_name $1 $2) -n $(get_namespace $1) $3
}

# kgp <namespace>
kgp () {
 if [[ -n $2 ]];then
   kubectl get pods -n $(get_namespace $1) -o wide
 else
   kubectl get pods -n $(get_namespace $1)
 fi
}

# kw <namespace>
kw () {
 if [[ -n $2 ]];then
   kubectl get pods -o wide -w -n $(get_namespace $1)
 else
   kubectl get pods -wn $(get_namespace $1)
 fi
}

# kgd <namespace>
kgd () {
 kubectl get deployments -n $(get_namespace $1)
}

# Describe Pod
# kdp <namespace> <pod>
kdp () {
  kubectl describe pod $(get_pod_name $1 $2) -n $(get_namespace $1)
}

# Describe deployments
# kdd <namespace> <pod>
kdd () {
  kubectl describe deployments $(get_deployment_name $1 $2) -n $(get_namespace $1)
}

# klogs <namespace> <pod> <container>
klogs () {
  if [[ -n $3 ]];then
   kubectl logs $(get_pod_name $1 $2) --container $3 -n $(get_namespace $1)
  else
   kubectl logs $(get_pod_name $1 $2) -n $(get_namespace $1)
  fi
}

# kscale <namespace> <deployment> <target>
kscale () {
 kubectl scale deployment $(get_deployment_name $1 $2) --replicas $3 -n $(get_namespace $1)
}

ktest () {
 kubectl run -i -t harry-busybox --image=busybox --restart=Never -- /bin/sh -n $(get_namespace $1)
}


ktop () {
 kubectl top nodes
}

kgc () {
 kubectl config get-contexts | awk {'print $1, $2'} | column -t
}

# ksc <context>
ksc () {
 kubectl config use-context $1
}

# kgn
kgn () {
  kubectl get namespaces
}

# kgi <namespace>
kgi () {
  kubectl get ingress -n $(get_namespace $1)
}

# kpdist
kpdist () {
  kubectl get pods --all-namespaces -o wide | awk '{print $8}' | sort | uniq -c
}

# kdebug <image>
kdebug () {
  image=$1
  kubectl run --rm -i --tty harry-toolkit --image=hapana/toolkit -- sh
}


# kmigcount
kmigcount () {
  kpdist | awk '{ print ($1 < 10) ? "true" : "false" }' | grep true | wc -l
}

# kcron <namespace> <cronjob> <integer>
kcron () {
  kubectl create job -n $(get_namespace $1) --from=cronjob/$2 hp-manual-test-$3
}

########
# HELM #
########

# kstate <namespace> <release>
kstate () {
  helm history $1 --tiller-namespace kube-system
  read number
  # For secret backed chart storage
  # kubectl get secrets --namespace $1 $2.v$number -o json | jq -r '.data.release'  | base64 -D | base64 -D | gzip -dc
  kubectl get configmap --namespace kube-system $1.v$number -o json| jq -r '.data.release'  | base64 -d  | gzip -dc
}

# krun image command
krun () {
  local image=$1
  local command=$2
  kubectl run -it temp --image=$image --command --rm=true --restart=Never  -- $command
}

# kga <type> <wide>
kga () {
  local type=$1
  kubectl get $type --all-namespaces -o wide
}

# kroll <namespace>
kroll () {
  local namespace=$1
  local pods=$2
  kubectl get pods -n $namespace | grep $2 | awk '{print $1}' | xargs -n 1 -I {} bash -c "kubectl delete pod -n $namespace {}; sleep 30"
}

khelp () {
 cat << EOF
# Deployment scaling
kscale staging console 1

# Get stuff
kgp namespace
kgd namespace

# Describe stuff
kdp namespace pod
kdd namespace pod

# Exec into things
kbash namespace pod [container]
kbsh namespace console [container]

# Get logs
klogs namespace pod [container]

# Port forward
kpf namespace pod port

# Performance
ktop

# Contexts
kgc
ksc

# Namespaces
kgn

# Ingress
kgi namespace

# Get pods per node
kpdist

# Long running pods
command: [ "/bin/ash", "-c", "--" ]
args: [ "while true; do sleep 3000000; done;" ]

# Roll pods
kroll <namespace>

# Watch pods
kw <namespace>

# Get number of drained nodes
kmigcount

# Get resources left in namespace
kleft namespace

# Create temporary cronjobs
kcron <namespace> <cronjob> <integer>

# Install kubectl
kinstall 1.19.0

# Custom columns
kubectl get pods --namespace default --output=custom-columns="NAME:.metadata.name,IMAGE:.spec.containers[*].image"
EOF
}

alias kctx="kubectl config current-context"
alias kap="kubectl pods --all-namespaces"
