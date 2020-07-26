source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'


function pick_project () {
  local short=$1

  case "$short" in
    prod)
      echo 'prod'
      ;;
    dev)
      echo 'dev'
      ;;
    *)
      echo "prod and dev supported"
      exit 1
      ;;
  esac
}

function pick_zone () {

}

# glist project
function glist () {
  local project=$1
  if [[ -z $project ]];then
    echo "Don't forget the project"
    return 1
  fi
  gcloud compute instances list --project $project
}

# gssh hostname env c
gssh (){
  if [[ -z $1 ]];then
    echo "Usage:\n  gssh hostname env c"
    return 0
  fi

  local hostname=$1
  local env=$2
  local zone=$3
  local project=""
  local fqdn=""

  project=$(pick_project $env)
  echo $project

  host=$(gcloud compute instances list --project $project | grep $1 | awk '{print $1}')
  fqdn="$host.europe-west4-$zone.c.$project.internal"
  echo "Host is $fqdn\nWant to carry on?(y)"
  read next
  if [ $next = "y" ]
  then
    ssh-add -D
    ssh-add ~/.ssh/google_compute_engine
    ssh $fqdn
    ssh-add ~/.ssh/id_rsa
  fi
}
