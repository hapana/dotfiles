alias gpom "git pull origin master"
alias gco "git checkout"
alias gcob "git checkout -b"
alias gr "git rebase"
alias gri "git rebase -i"
alias gdc "git diff --cached"
alias gs "git status"
alias gd "git diff"
alias gap "git add -p ."
alias gbd "git branch -D"
alias ga "git add"

function log
  set message $argv[1]
  set date (date "+%d-%m-%Y %H:%M:%S")
  echo "$date - $message"
end

# gitcp <source file> <branch name> <commit message>
# Need to pipe a list of dirs into this
function gitcp
  set src_file_path $argv[1]
  set branch_name $argv[2]
  set message $argv[3]
  set src_file_name "(basename -- $src_file_path)"

  log "Copying $src_file_path..."

  while read dir
    log "Directory is $dir"
    pushd $dir > /dev/null
    if test (git branch | grep develop)
      log "Checkout develop then branch from it"
      git fetch
      git checkout develop
      git pull origin develop
      git checkout -b $branch_name
      if test $status -ne 0
        log "Can't checkout develop"
        popd > /dev/null
        continue
      end
    else
      log "Checkout master then branch from it"
      git fetch
      git checkout master
      git pull origin master
      git checkout -b $branch_name
      if test $status -ne 0
        logo "Can't checkout develop"
        popd > /dev/null
        continue
      end
    end

    log "Copy file from $src_file_path to $dir"
    cp ../$src_file_path $dir/$src_file_name
    log "Current dir is (pwd)"
    git add ./$src_file_name
    log "Committing with $message"
    git commit -m \"$message\"
    popd > /dev/null
  end
end
