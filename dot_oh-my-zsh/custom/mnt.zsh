# mntfiles games
mntfiles () {
  sudo mkdir -p /mnt/$1
  sudo mount nas:/export/$1 /mnt/$1
}

umntfiles () {
  sudo umount /mnt/$1
}
