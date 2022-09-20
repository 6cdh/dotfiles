export ZSH="${HOME}/.oh-my-zsh"

# To use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Speedup zsh-autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND="true"

plugins=(
    colored-man-pages
    extract
    fast-syntax-highlighting
    fd
    git
    ripgrep
    rust
    vi-mode
    zoxide
    zsh-autosuggestions
    fzf
)

source $ZSH/oh-my-zsh.sh

# History size
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt extendedglob nomatch notify
unsetopt autocd beep

export VI_MODE_SET_CURSOR=true

# Auto Rehash
zstyle ':completion:*' rehash true

# aliases
source ~/.zshcfg/.zsh_aliases.sh
# function
source ~/.zshcfg/.zsh_func.sh

# nix
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

lcproxy_enable

eval "$(starship init zsh)"

