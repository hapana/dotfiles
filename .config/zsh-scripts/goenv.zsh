eval "$(goenv init -)"

function gehelp () {
cat <<EOF
  # Install version
  goenv install 1.10.1

  # Use version
  goenv global 1.10.1
EOF
}
