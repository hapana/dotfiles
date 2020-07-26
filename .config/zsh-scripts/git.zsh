alias gpom="git pull origin master"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gr="git rebase"
alias gri="git rebase -i"
alias gdc="git diff --cached"
alias gs="git status"
alias gd="git diff"
alias gap="git add -p ."
alias gbd="git branch -D"

log () {
  message=$1
  date=$(date "+%d-%m-%Y %H:%M:%S")
  echo "$date - $message"
}

# gitcp <source file> <branch name> <commit message>
# Need to pipe a list of dirs into this
gitcp () {
  src_file_path=$1
  branch_name=$2
  message=$3
  src_file_name="$(basename -- $src_file_path)"

  log "Copying $src_file_path..."

  while read dir;do
    log "Directory is $dir"
    pushd $dir > /dev/null
    if [[ $(git branch | grep develop) ]];then
      log "Checkout develop then branch from it"
      git fetch
      git checkout develop
      git pull origin develop
      git checkout -b $branch_name
      if [[ $? -ne 0 ]];then
        log "Can't checkout develop"
        popd > /dev/null
        continue
      fi
    else
      log "Checkout master then branch from it"
      git fetch
      git checkout master
      git pull origin master
      git checkout -b $branch_name
      if [[ $? -ne 0 ]];then
        logo "Can't checkout develop"
        popd > /dev/null
        continue
      fi
    fi

    log "Copy file from $src_file_path to $dir"
    cp ../$src_file_path $dir/$src_file_name
    log "Current dir is $(pwd)"
    git add ./$src_file_name
    log "Committing with $message"
    git commit -m \"$message\"
    popd > /dev/null
  done
}
