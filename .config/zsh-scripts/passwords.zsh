# htpasswd -bnBC 10 "" password | tr -d ':\n'
passhelp () {
  cat << EOF
Bcrypt password hashes: htpasswd -bnBC 10 "" <password> | tr -d ':\n'
EOF
}

