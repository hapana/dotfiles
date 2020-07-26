reload_zsh () {
  source ~/.zshrc
}

source /usr/local/etc/profile.d/z.sh

split_yaml () {
  csplit -s --suffix "%03d.yaml" -k "$1" /---/ '{*}'
}
