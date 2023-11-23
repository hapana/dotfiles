# htpasswd -bnBC 10 "" password | tr -d ':\n'
function passhelp
  echo '
  Bcrypt password hashes: htpasswd -bnBC 10 "" <password> | tr -d ':\n'
  '
end
