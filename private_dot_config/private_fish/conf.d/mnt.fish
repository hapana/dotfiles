# mntfiles games
function mntfiles
  set point $argv[1]
  sudo mkdir -p /mnt/$point
  sudo mount nas:/export/$point /mnt/$point
end

function umntfiles
  sudo umount /mnt/$1
end
