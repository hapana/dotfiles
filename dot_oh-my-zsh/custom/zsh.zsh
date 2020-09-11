reload_zsh () {
  source ~/.zshrc
}

split_yaml () {
  csplit -s --suffix "%03d.yaml" -k "$1" /---/ '{*}'
}
