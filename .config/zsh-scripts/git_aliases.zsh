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
alias grim="git rebase -i origin/master"

ghelp () {
cat <<EOF
gpom: git pull origin master"
gco: git checkout"
gcob: git checkout -b"
gr: git rebase"
gri: git rebase -i"
gdc: git diff --cached"
gs: git status"
gd: git diff"
gap: git add -p ."
gbd: git branch -D"
grim: git rebase -i origin/master"
EOF
}
