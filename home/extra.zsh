export DEFAULT_USER="axis"
export VISUAL=nvim
export EDITOR="$VISUAL"

export BAT_THEME="zenburn"

# lower vi-mode escape delay
KEYTIMEOUT=1

# backspace can go beyond beginning of insertion point
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

unsetopt correct_all
unsetopt share_history

PATH="$HOME/.ghcup/bin:$PATH"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End NixA
