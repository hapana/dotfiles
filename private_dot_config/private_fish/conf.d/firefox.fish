alias myfirefox "/Applications/Firefox.app/Contents/MacOS/firefox-bin -P"

function ffhelp
  echo '
    - h, j, k, l: scroll left, down, right, up, and right
    - j, k: scroll vertically
    - h, l: scroll horizontally
    - Ctrl+U, Ctrl+D: scroll pages by half of screen
    - Ctrl+B, Ctrl+F: scroll pages by a screen
    - 0, $: scroll a page to leftmost/rightmost
    - gg, G: scroll to top/bottom

    - gg, G: scroll to top and bottom
    - d: delete current tab
    - u: reopen close tab
    - K, J: select prev or next tab
    - r: reload current tab
    - zp: toggle pin/unpin current tab
    - zd: duplicate current tab

    - f: start following links in the page
    - H: go back in histories
    - L: go forward in histories
    - [[, ]]: find prev or next links and open it
    - gu: go to parent directory
    - gU: go to root directory

    - :: open console
    - o, t, w: open a page in current tab, new tab, or new window
    - O, T, W: similar to o, t, w, but that contains current URL
    - b: Select tabs by URL or title
    - zi, zo: zoom-in/zoom-out
    - zz: Set default zoom level
    - y: copy URL in current tab
    - Shift+Esc: enable or disable the add-on in current tab.
  '
end
