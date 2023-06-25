# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End NixA

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

# Show packages loaded via nix shell
export NIXSHELL=$(echo $PATH | tr ':' '\n' | grep '/nix/store' | sed 's#^/nix/store/[a-z0-9]*-##' | sed 's#-[^-]\+$##' | head -n 3 | xargs -d '\n')

PATH="$HOME/.ghcup/bin:$HOME/.local/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
