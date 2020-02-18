# add snaps to path
export PATH="$HOME/bin:$HOME/.local/bin:/snap/bin:$PATH"

# also add snap stuff to xdg
# (also, this needs to be prefixed with the defaults when tampering,
# because Ubuntu simply doesn't set these vars by default)
export XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/snapd/desktop"

# help code be the default editor
export VISUAL=code
export EDITOR="$VISUAL"