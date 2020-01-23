# dirs <command>
dirs () {
  local command=$1
  local dirs=$(ls)
  for dir in $(ls)
  do
    pushd "./$dir" > /dev/null
    #eval $(command)
    eval $command
    popd > /dev/null
  done
}
