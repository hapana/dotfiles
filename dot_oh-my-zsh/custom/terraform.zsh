td () {
  local path=$1
  terraform-docs md $path
}

tf () {
  local path=$1
  terraform fmt $path
}
