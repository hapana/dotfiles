BASE64_DECODER="base64 -d" # option -d for Linux base64 tool
echo AAAA | base64 -d > /dev/null 2>&1 || BASE64_DECODER="/usr/local/Cellar/base64/1.5/bin/base64 -D" # option -D on MacOS

decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'='
  fi
  echo "$result" | tr '_-' '/+' | $BASE64_DECODER
}

decode_jose(){
   decode_base64_url $(echo -n $2 | cut -d "." -f $1) | jq .
}

decode_jwt_part(){
   decode_jose $1 $2 | jq 'if .iat then (.iatStr = (.iat|todate)) else . end | if .exp then (.expStr = (.exp|todate)) else . end | if .nbf then (.nbfStr = (.nbf|todate)) else . end'
}

decode_jwt(){
   decode_jwt_part 1 $1
   decode_jwt_part 2 $1
}

# Decode JWT header
alias jwth="decode_jwt_part 1"

# Decode JWT Payload
alias jwtp="decode_jwt_part 2"

# Decode JWT header and payload
alias jwthp="decode_jwt"

# Decode JWE header
alias jweh="decode_jose 1"
