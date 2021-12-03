export PROXY_ADDR="127.0.0.1:4097"
export PROXY_ENV="http_proxy=http://${PROXY_ADDR} https_proxy=http://${PROXY_ADDR} no_proxy=localhost,127.0.0.1"

# config
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

# package manager
# alias pip="${PROXY_ENV} pip"
alias pub="${PROXY_ENV} pub"
alias cargo="${PROXY_ENV} cargo"
alias npm="${PROXY_ENV} npm"
alias yarn="${PROXY_ENV} yarn"

# programming
alias py="python3"
alias supy="sudo python3"
alias go="${PROXY_ENV} go"
alias cl="clang++"

# application
alias spp="sudo proxychains4"
alias pp="proxychains4"

# typo
alias suod="sudo"

# common
alias ls="exa"
alias l="ls -l"
alias ll="ls -la"
alias la="ls -la"
alias free="free -h"
alias du="du -h"
alias df="df -h"
alias vi="${PROXY_ENV} nvim"
alias gvi="${PROXY_ENV} nvim-gtk"
alias suvi="${PROXY_ENV} sudo nvim"
alias emacs="${PROXY_ENV} emacs"
alias diff="diff --color=always"
alias googler="${PROXY_ENV} googler"
alias how2="${PROXY_ENV} how2"
alias tldr="${PROXY_ENV} tldr"
alias rlwrap="rlwrap -pgreen"

# git
alias gcl1="git clone --depth 1"
