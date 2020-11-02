alias flush_dns='sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache'

machelp () {
  cat << EOF
# Switch desktops
ctrl + arrows

# Spectacle thirds
ctrl + alt + arrows

# Spectacle halves
alt + special key + arrows
EOF
}
