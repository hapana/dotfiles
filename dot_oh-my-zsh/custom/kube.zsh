export PATH=$PATH:$HOME/.linkerd2/bin

alias k="kubectl"
get_pod_name() {
  echo $(kubectl -n $1 get pods | grep $2 | cut -d' ' -f1 | head -n 1)
}

get_deployment_name(){
  echo $(kubectl -n $1 get deployments | grep $2 | cut -d' ' -f1)
}

# Load autocompletions
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# kbash <namespace> <pod> <container>
kbash () {
  if [[ -n $3 ]];then
    kubectl -n $1 exec -it $(get_pod_name $1 $2) --container $3 /bin/bash
  else
    kubectl -n $1 exec -it $(get_pod_name $1 $2) /bin/bash
  fi
}

# kbsh <namespace> <pod> <container>
kbsh () {
  if [[ -n $3 ]];then
    kubectl -n $1 exec -it $(get_pod_name $1 $2) --container $3 /bin/sh
  else
    kubectl -n $1 exec -it $(get_pod_name $1 $2) /bin/sh
  fi
}

# kpf <namespace> <pod> <port>
kpf () {
    kubectl -n $1 port-forward $(get_pod_name $1 $2) $3
}

# kgp <namespace>
kgp () {
 if [[ -n $2 ]];then
   kubectl -n $1 get pods -o wide
 else
   kubectl -n $1 get pods
 fi
}

# kw <namespace>
kw () {
 if [[ -n $2 ]];then
   kubectl -n $1 get pods -o wide -w
 else
   kubectl -n $1 get pods -w
 fi
}

# kgd <namespace>
kgd () {
 kubectl -n $1 get deployments
}

# Describe Pod
# kdp <namespace> <pod>
kdp () {
  kubectl -n $1 describe pod $(get_pod_name $1 $2)
}

# Describe deployments
# kdd <namespace> <pod>
kdd () {
  kubectl -n $1 describe deployments $(get_deployment_name $1 $2)
}

# klogs <namespace> <pod> <container>
klogs () {
  if [[ -n $3 ]];then
   kubectl -n $1 logs $(get_pod_name $1 $2) --container $3
  else
   kubectl -n $1 logs $(get_pod_name $1 $2)
  fi
}

# kscale <namespace> <deployment> <target>
kscale () {
 kubectl -n $1 scale deployment $(get_deployment_name $1 $2) --replicas $3
}

ktest () {
 kubectl -n $1 run -i -t harry-busybox --image=busybox --restart=Never -- /bin/sh
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
  kubectl get ingress -n $1
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

########
# HELM #
########

# kstate <namespace> <release>
kstate () {
  helm history $2 --tiller-namespace $1
  read number
  # For secret backed chart storage
  # kubectl get secrets --namespace $1 $2.v$number -o json | jq -r '.data.release'  | base64 -D | base64 -D | gzip -dc
  kubectl get configmap --namespace $1 $2.v$number -o json| jq -r '.data.release'  | base64 -d  | gzip -dc
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
  kubectl get pods -n $namespace | awk '{print $1}' | tail +2 | xargs kubectl delete pod -n $namespace
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

EOF
}

alias kctx="kubectl config current-context"
alias kap="kubectl pods --all-namespaces"
