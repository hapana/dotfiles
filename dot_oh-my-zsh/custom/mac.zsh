alias flush_dns='sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache'

machelp () {
  cat << EOF

# Switch desktop
ctrl + arrows

# Spectacle thirds
ctrl + alt + arrrows

# Spectacle halves
special + alt + arrows
EOF
}
