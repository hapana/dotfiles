function td
  set path $1
  terraform-docs md $path
end

function tf
  set path $1
  terraform fmt $path
end
