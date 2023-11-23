#export PATH=$PATH:$HOME/.linkerd2/bin

# Main alias
alias k "kubectl"

# Helper functions to ge the first of things
function get_pod_name
  echo (kubectl get pods -n (get_namespace $argv[1])| grep $argv[2] | cut -d' ' -f1 | head -n 1)
end

function get_deployment_name
  echo (kubectl get deployments -n (get_namespace $argv[1]) | grep $argv[2] | cut -d' ' -f1)
end

function get_namespace
  echo (kubectl get namespaces | grep $argv[1] | cut -d' ' -f1 | head -n 1)
end

# Load autocompletions
#if [ $commands[kubectl] ]; then
#  source <(kubectl completion zsh)
#fi

# k_install 1.21.0
function kinstall
  set version $argv[1]
  pushd /tmp
  if test -n $version
    curl -LO "https://dl.k8s.io/release/v$version/bin/darwin/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/v$version/bin/darwin/amd64/kubectl.sha256"
    echo "(<kubectl.sha256)  kubectl" | shasum -a 256 --check
  else
    curl -LO "https://dl.k8s.io/release/(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl.sha256"
    echo "(<kubectl.sha256)  kubectl" | shasum -a 256 --check
  end
  chmod +x /tmp/kubectl
  popd
  mv /tmp/kubectl /usr/local/bin/kubectl
end

# kbash <namespace> <pod> <container>
function kbash
  set namespace $argv[1]
  set pod $argv[2]
  set container $argv[3]
  if test -n $argv[3]
    kubectl exec -it (get_pod_name $namespace $pod) -n (get_namespace $namespace) --container $conainer /bin/bash
  else
    kubectl exec -it (get_pod_name $namespace $pod) -n (get_namespace $namespace) /bin/bash
  end
end

# kleft <namespace>
function kleft
  kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n (get_namespace $argv[1])
end

# kbsh <namespace> <pod> <container>
function kbsh
  set namespace $argv[1]
  set pod $argv[2]
  if set -q $argv[3]
    set container $argv[3]
    set thing kubectl exec -n (get_namespace $namespace) --container $container  -it (get_pod_name $namespace $pod) -- /bin/sh
    echo $thing
    eval $thing
  else
    set thing kubectl exec -n (get_namespace $namespace) -it (get_pod_name $namespace $pod)  -- /bin/sh
    echo $thing
    eval $thing
  end
end

# kpf <namespace> <pod> <port>
function kpf
  set namespace $argv[1]
  set pod $argv[2]
  set port $argv[3]
  kubectl port-forward (get_pod_name $namespace $pod) -n (get_namespace $namespace) $port
end

# kgp <namespace>
function kgp
  set namespace $argv[1]
  set pod $argv[2]
  if test -n $pod
    kubectl get pods -n (get_namespace $namespace) -o wide
  else
    kubectl get pods -n (get_namespace $namespace)
  end
end

# kw <namespace>
function kw
  set namespace $argv[1]
  set pod $argv[2]
  if test -n $pod
    kubectl get pods -o wide -w -n (get_namespace $namespace)
  else
    kubectl get pods -wn (get_namespace $namespace)
  end
end

# kgd <namespace>
function kgd
 kubectl get deployments -n (get_namespace $argv[1])
end

# Describe Pod
# kdp <namespace> <pod>
function kdp
  set namespace $argv[1]
  set pod $argv[2]
  kubectl describe pod (get_pod_name $namespace $pod) -n (get_namespace $namespace)
end

# Describe deployments
# kdd <namespace> <pod>
function kdd
  set namespace $argv[1]
  set pod $argv[2]
  kubectl describe deployments (get_deployment_name $namespace $pod) -n (get_namespace $namespace)
end

# klogs <namespace> <pod> <container>
function klogs
  set namespace $argv[1]
  set pod $argv[2]
  set container $argv[3]
  if test $argv[3]
   kubectl logs (get_pod_name $namespace $pod) --container $container -n (get_namespace $namespace)
  else
   kubectl logs (get_pod_name $namespace $pod) -n (get_namespace $namespace)
  end
end

# kscale <namespace> <deployment> <target>
function kscale
 kubectl scale deployment (get_deployment_name $argv[1] $argv[2]) --replicas $argv[3] -n (get_namespace $argv[2])
end

function ktest
 kubectl run -i -t harry-busybox --image=busybox --restart=Never -- /bin/sh -n (get_namespace $argv[1])
end


function ktop
 kubectl top nodes
end

function kgc
 kubectl config get-contexts | awk '{print $1, $2}' | column -t
end

# ksc <context>
function ksc
 kubectl config use-context $argv[1]
end

# kgn
function kgn
  kubectl get namespaces
end

# kgi <namespace>
function kgi
  kubectl get ingress -n (get_namespace $argv[1])
end

# kpdist
function kpdist
  kubectl get pods --all-namespaces -o wide | awk '{print $8}' | sort | uniq -c
end

# kdebug <image>
function kdebug
  set image $argv[1]
  kubectl run --rm -i --tty harry-toolkit --image=hapana/toolkit -- sh
end


# kmigcount
function kmigcount
  kpdist | awk ' print ($1 < 10) ? "true" : "false" }' | grep true | wc -l
end

# kcron <namespace> <cronjob> <integer>
function kcron
  kubectl create job -n (get_namespace $argv[1]) --from=cronjob/$argv[2] hp-manual-test-$argv[3]
end

########
# HELM #
########

# kstate <namespace> <release>
function kstate
  helm history $argv[1] --tiller-namespace kube-system
  read number
  # For secret backed chart storage
  # kubectl get secrets --namespace $1 $2.v$number -o json | jq -r '.data.release'  | base64 -D | base64 -D | gzip -dc
  kubectl get configmap --namespace kube-system $argv[1].v$number -o json| jq -r '.data.release'  | base64 -d  | gzip -dc
end

# krun image command
function krun
  set image $argv[1]
  set command $argv[2]
  kubectl run -it temp --image=$image --command --rm=true --restart=Never  -- $command
end

# kga <type> <wide>
function kga
  set type $argv[1]
  kubectl get $type --all-namespaces -o wide
end

# kroll <namespace>
function kroll
  set namespace $argv[1]
  set pods $argv[2]
  kubectl get pods -n $namespace | grep $pods | awk '{print $1}' | xargs -n 1 -I {} bash -c "kubectl delete pod -n $namespace {}; sleep 30"
end

function khelp
echo '
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
'
end

alias kctx "kubectl config current-context"
alias kap "kubectl pods --all-namespaces"
