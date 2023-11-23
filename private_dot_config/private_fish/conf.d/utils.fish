# dirs <command>
function dirs
  set command $argv[1]
  set dirs (ls)
  for dir in (ls)
  do
    pushd "./$dir" > /dev/null
    #eval $(command)
    eval $command
    popd > /dev/null
  end
end
