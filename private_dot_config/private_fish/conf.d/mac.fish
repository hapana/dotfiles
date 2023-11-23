alias flush_dns 'sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache'
alias flush_dns_alt 'sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist;sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist'

function machelp
  echo '
    # Switch desktops
    ctrl + arrows

    # Spectacle thirds
    ctrl + alt + arrows

    # Spectacle halves
    alt + special key + arrows
  '
end
