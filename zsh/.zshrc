# zmodload zsh/zprof

export ZSH="${HOME}/.oh-my-zsh"

# To use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Disable marking untracked files under VCS as dirty. This makes repository 
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
    cargo
    colored-man-pages
    extract
    fast-syntax-highlighting
    fd
    git
    ripgrep
    rustup
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

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Auto Rehash
zstyle ':completion:*' rehash true

# completion
fpath+=~/.zfunc

#aliases
source ~/.zsh_aliases.sh
# function
source ~/.zsh_func.sh

eval "$(starship init zsh)"
