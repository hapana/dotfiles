get_pod_name() {
  echo $(kubectl -n $1 get pods | grep $2 | cut -d' ' -f1 | head -n 1)
}

get_deployment_name(){
  echo $(kubectl -n $1 get deployments | grep $2 | cut -d' ' -f1)
}

# kbash staging paysvc-live pay
kbash () {
  if [[ -n $3 ]];then
    kubectl -n $1 exec -it $(get_pod_name $1 $2) --container $3 /bin/bash
  else
    kubectl -n $1 exec -it $(get_pod_name $1 $2) /bin/bash
  fi
}

# kbsh staging paysvc-live pay
kbsh () {
  if [[ -n $3 ]];then
    kubectl -n $1 exec -it $(get_pod_name $1 $2) --container $3 /bin/sh
  else
    kubectl -n $1 exec -it $(get_pod_name $1 $2) /bin/sh
  fi
}

# kpf staging prom 8080
kpf () {
    kubectl -n $1 port-forward $(get_pod_name $1 $2) $3
}

# kpods staging
kgp () {
 kubectl -n $1 get pods
}

# kpods staging
kgd () {
 kubectl -n $1 get deployments
}

# kd staging console
kdp () {
  kubectl -n $1 describe pod $(get_pod_name $1 $2)
}

# kd staging console
kdd () {
  kubectl -n $1 describe deployments $(get_deployment_name $1 $2)
}

# klogs staging paysvc-sandbox pay
klogs () {
  if [[ -n $3 ]];then
   kubectl -n $1 logs $(get_pod_name $1 $2) --container $3
  else
   kubectl -n $1 logs $(get_pod_name $1 $2)
  fi
}

# kscale staging console 1
kscale () {
 kubectl -n $1 scale deployment $(get_deployment_name $1 $2) --replicas $3
}

ktest () {
 kubectl -n $1 run -i -t harry-busybox --image=busybox --restart=Never -- /bin/sh
}


ktop () {
 kubectl top nodes
}

########
# HELM #
########

# kstate <namespace> <release>
kstate () {
  helm history $2 --tiller-namespace $1-tiller
  read number
  kubectl get secrets --namespace $1-tiller $2.v$number -o json | jq -r '.data.release'  | base64 -d | base64 -d | gzip -dc
}


khelp () {
 cat << EOF
# Deployment scaling
kscale staging console 1

# Get stuff
kgp staging
kgd staging

# Describe stuff
kdp staging console
kdd staging console

# Bash into things
kbash staging console [haproxy]

# Get logs
klogs staging console [haproxy]

# Port forward
kpf staging prometheus 8080
EOF
}

alias kctx="kubectl config current-context"
alias kap="kubectl pods --all-namespaces"
